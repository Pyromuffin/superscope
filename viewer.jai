//
// This is an example of how to use GetRect.
//
// GetRect is in its period of initial creation and is still evolving quickly.
// One important thing to know is, there is no notion of global focus yet,
// so we do some manual focus wrangling in here. We'll clean that up eventually.
//
// Also, this demo will be made cosmetically nicer in the end. Right now it just
// demonstrates how to do the various types of controls, but ultimately the goal
// is that GetRect does not look ugly by default, unlike many other UI systems.
//

#import "GetRect";  // Other imports are below, but the point of this example is to use GetRect so this #import goes here.
#import "fst";
#import "Input";

//
// This example was copied from modules/Simp/examples/example.jai.
// It will continue to diverge over time, probably.
//

SCALE :: 1;  // I use this during development to quickly make the window real big.

my_window: Window_Type;
window_width  : s32 = xx (1920*SCALE);
window_height : s32 = xx (1080*SCALE);

current_time: float64;
last\  _time: float64;

// Data values that we manipulate with the widgets:

scroll_value: float;
scroll_value_dragdrop_region: float;

// Data values that we manipulate with the widgets:

Grocery_Info :: struct {
    name: string;
    should_get := false;
}

groceries: [..] Grocery_Info;


dropped_files: [..] string;

spells: [..] string;  // We make a radio button of which spell to cast.
current_spell := -1;


Damage_Resistance :: enum_flags u16 {
    PIERCING;
    SLASHING;
    CRUSHING;
    BLUNT;
    ELECTRICAL :: 0x40;
    MAGIC;
    POISON;
    ELEMENTAL;
    EMOTIONAL;
}

damage_resistance: Damage_Resistance;

awesome_theme_names :: string.["Blood Vampire", "Very Dark", "Chai Juice", "Peach Panther", "Emotional Damage", "Rays of Sunshine", "THEMERUNKNOWN'S THEMEGROUNDS", "Chaos!!!!"];

teas :: string.["Earl Gray", "Singapore Breakfast", "Bengal Spice", "Hot Cinnamon Spice", "Tie Guanyin", "Lapsang Souchong", "Royal Pu-Erh", "Chai Juice", "Snore and Peace", "Genmaicha", "Jasmine Pearls", "Sencha", "Gyokuro", "White Claw", "Rooibos", "Alishan Oolong"];

TEXT_FIELD_1 :: #string DONE
I thence
Invoke thy aid to my adventurous song,
That with no middle flight intends to soar
Above th' Aonian mount, while it pursues
Things unattempted yet in prose or rhyme.
And chiefly thou, O Spirit, that dost prefer
Before all temples th' upright heart and pure,
Instruct me, for thou know'st; thou from the first
Wast present, and, with mighty wings outspread,
Dove-like sat'st brooding on the vast Abyss,
And mad'st it pregnant: what in me is dark
Illumine, what is low raise and support;
That, to the height of this great argument,
I may assert Eternal Providence,
And justify the ways of God to men.
DONE

slider_float_value: float = 27.02;
slider_int_value  : s32 = 3;

current_theme: s32 = 0;

picked_color: Vector3 = .{.1, .8, .6};

// For windows that move around autonomously:
subwindow_info_text:   Subwindow_Info;
subwindow_info_circle: Subwindow_Info;
subwindows_initted := false;


// @Cleanup: Get rid of the need for begins_with_count?
begins_with_count :: (str: string, prefix: string) -> int {
    for 0..prefix.count-1 {
        if it >= str.count || str[it] != prefix[it] return it;
    }
    
    return prefix.count;
}

auto_complete_teas :: (input: string, data: *void) -> (results: [] string, longest_match_length: int) {
    results: [..] string;

    longest_match_length := 0;
    for teas {
        count := begins_with_count(it, input);
        if count == input.count {
            array_add(*results, it);
            longest_match_length = max(longest_match_length, input.count);
        }

        longest_match_length = max(longest_match_length, count);
    }

    return results, longest_match_length;
}


signals : [..] Signal;

main :: () {

    signals = LoadSignals("C:\\Users\\pyrom\\Desktop\\jai\\FST\\test.fst");
    dummy : [..] Vector3;
    array_add(*signalVerts, dummy);

    for signals {
        if(it_index == 0) continue;
        verts := CalculateSignalVertices(it, 300);
        array_add(*signalVerts, verts);
    }

    #if OS == .WINDOWS {
        Windows :: #import "Windows";
        Windows.SetProcessDPIAware();

        // Windows is very bad at thread-switching by default unless you do this. Sad.
        Windows.timeBeginPeriod(1);
    }

    my_window = create_window(window_width, window_height, "A Window");
    #if OS == .WINDOWS {
        // @Feature: Add user-specific typelist support.
        Windows.DragAcceptFiles(my_window, cast(Windows.BOOL) true);
    } else #if OS == .LINUX {
        X11 :: #import "X11";
        typelist := string.["url/url", "text/uri-list", "text/plain", "application/octet-stream"];
        X11.enable_drag_and_drop(my_window, typelist);
    } else #if OS == .MACOS {
        // @Incomplete
    }


    Simp.set_render_target(my_window);
    
    my_init_fonts();
    ui_init();

    
    // Add some groceries.

    g := array_add(*groceries);
    g.name = "Apples";
    
    g = array_add(*groceries);
    g.name = "Bananas";
    
    g = array_add(*groceries);
    g.name = "Moon Chips";

    g = array_add(*groceries);
    g.name = "Chai Juice";


    array_add(*spells, "rezrov");
    array_add(*spells, "gondar");
    array_add(*spells, "gnusto");
    array_add(*spells, "aimfiz");

    
    quit := false;
    while !quit {
        current_time = get_time();
        dt := cast(float)(current_time - last_time);
        Clamp(*dt, 0, 0.1);
        last_time = current_time;

        Input.update_window_events();

        for Input.get_window_resizes() {
            Simp.update_window(it.window);

            if it.window == my_window {
                should_reinit := (it.width != window_width) || (it.height != window_height);
                
                window_width  = it.width;
                window_height = it.height;
                
                if should_reinit my_init_fonts();  // Resize the font for the new window size.
            }
        }
        
        for event: Input.events_this_frame {
            if event.type == .QUIT then quit = true;

            getrect_handle_event(event);

            if event.type == {
              case .KEYBOARD;
                if event.key_pressed && event.key_code == .ESCAPE {
                    active_widget_deactivate_all();
                }
              case .DRAG_AND_DROP_FILES;
                for dropped_files free(it);
                array_reset(*dropped_files);
                for event.files array_add(*dropped_files, copy_string(it));
            }
        }

        draw_one_frame(dt);
        
        reset_temporary_storage();
        sleep_milliseconds(10);
    }
}


signalString := "";
signalVerts : [..][..]Vector3;
selectedAny := false;
wavePitch := 10.0;
waveHeight := 30.0;
waveOffset := 0.0;

vec3 :: make_vector3;

DrawTimelineTicks :: (graph : Rect, pitch : float, thickness : float, offset : float) {
    tickLength := pitch;
    phase := fmod_cycling(offset, tickLength) * vec3(1,0,0);
    numberOfTicks := cast(int)ceil(graph.w / tickLength);
    for 0 .. numberOfTicks - 1 {
        pos := vec3(graph.x, graph.y, 0) + phase;
        pos.x += it * tickLength;
        DrawLine(pos, pos + vec3(0,1,0) * graph.h, thickness, Vector4.{0,0.3,0,1} );
    }

    Simp.immediate_flush();
}


DrawRect :: ( r : Rect, color : Vector4 = Vector4.{1,1,1,1} ) {
    Simp.set_shader_for_color();
    p0 := vec3(r.x, r.y, 0);
    p1 := vec3(r.x + r.w, r.y, 0);
    p2 := vec3(r.x + r.w, r.y + r.h, 0);
    p3 := vec3(r.x, r.y + r.h, 0);

    Simp.immediate_quad(p0,p1,p2,p3, color);
    Simp.immediate_flush();
}

// we probably want to create a generic scrollbar state for this.
dragging := false;

ProcessScrollBarClicks :: ( scrollRect : Rect ) -> bool, float {
    
    mouseX, mouseY, success := get_mouse_pointer_position(my_window, true);
    clickOrHold := input_button_states[Key_Code.MOUSE_BUTTON_LEFT] & Key_Current_State.START || input_button_states[Key_Code.MOUSE_BUTTON_LEFT] & Key_Current_State.DOWN;
    draggingOutsideWindow := dragging && ( input_button_states[Key_Code.MOUSE_BUTTON_LEFT] & Key_Current_State.DOWN );

    insideScrollBar := is_inside( xx mouseX, xx mouseY, scrollRect) && clickOrHold;


    if draggingOutsideWindow || insideScrollBar {
        // find the relative position within the rect.
        dragging = true;
        x := mouseX - scrollRect.x;
        xFraction := x / scrollRect.w;

        return true, xFraction;
    }
        
    dragging = false;
    return false, 0;
}

ProcessMiddleClickDragging :: (graphRect : Rect) -> bool, int {
    mouseX, mouseY, success := get_mouse_pointer_position(my_window, true);
    middleClick := input_button_states[Key_Code.MOUSE_BUTTON_MIDDLE] & Key_Current_State.START || input_button_states[Key_Code.MOUSE_BUTTON_MIDDLE] & Key_Current_State.DOWN;
    insideGraph := is_inside( xx mouseX, xx mouseY, graphRect) && middleClick;

    if insideGraph {
        return true, mouse_delta_x;
    }
        
    return false, 0;
}



IsCtrlPressed :: () -> bool {
    return input_button_states[Key_Code.CTRL] & Key_Current_State.START || input_button_states[Key_Code.CTRL] & Key_Current_State.DOWN;
}

Vectors :: struct {
    up :: Vector3.{0,1,0};
    down :: Vector3.{0,-1,0};
    left :: Vector3.{-1,0,0};
    right :: Vector3.{1,0,0};
}

DrawScrollBar::( center : Vector3, totalWidth : float, viewableSize : float, offset : float, height : float) {
    using Vectors;
    Simp.set_shader_for_color();
    // the size of the scroll bar is the viewed fraction ?
    viewedFraction := (viewableSize/totalWidth);
    barThickness := viewedFraction * viewableSize;

    // an offset of zero means the bar should be touching the left side of the viewable area.
    leftWall := center;
    leftWall.x -= viewableSize / 2;
    barCenter := leftWall + right * barThickness/2;
    movableArea := viewableSize - barThickness;

    // we want to move the bar center 1 movable area when the offset causes use to scroll the total distance.
    // when offset is zero, the left side of the graph is on the left side
    // when offset is -total size, the graph is completely off screen.
    
    scrolledFraction := abs(offset) / (totalWidth - viewableSize);
    barCenter.x += movableArea * scrolledFraction;

    p0 := barCenter + left * barThickness / 2 + up * height /2;
    p1 := barCenter + right * barThickness / 2 + up * height /2;
    p2 := barCenter + right * barThickness / 2 + down * height /2;
    p3 := barCenter + left * barThickness / 2 + down * height /2;

    Simp.immediate_quad(p0,p1,p2,p3, Vector4.{1,1,1,1});
    Simp.immediate_flush();
}

draw_one_frame :: (dt: float) {
    // Simp.update_window(my_window);
    Simp.clear_render_target(.15, .11, .11, 1);

    x, y, width, height := get_dimensions(my_window, true);
    ui_per_frame_update(my_window, width, height, current_time);

    button_theme: Button_Theme;  // This will have the default Button_Theme values.
    button_theme.font = button_font;
    button_theme.enable_variable_frame_thickness = true; 
    // 'k' is some resolution-adjusting unit of distance. Right now it is
    // 1/10 of the screen height, so, 108 pixels at 1920x1080.
    k := window_height * .1;
    r := get_rect(k*.5, 9*k, k * 3, k/3);

    button_theme.label_theme.alignment = .Left;

    pressed : bool;

    startHeight := r.y;

    for signals {
        if(it_index == 0 || it_index == signals.count -1) continue;
        pressed = button(r, it.name, *button_theme, it_index);
        r.y -= k/3;
    }

    graphWidth := window_width - k*3.5;
    graphHeight := (signals.count -1) * k/3;
    graphRect := get_rect(r.x + k *3, r.y, graphWidth, graphHeight);
    scrollRect := get_rect(r.x + k* 3, r.y, graphWidth, waveHeight * 1.5);
    totalWidth := GetTimeOfLastTransition() * wavePitch;
    maxOffset := (totalWidth - graphWidth);


    // input processing

    if(mouse_delta_z) {
        if(IsCtrlPressed())
            wavePitch += ifx mouse_delta_z > 0 then 1 else -1;
        else
            waveOffset += mouse_delta_z ;
    }

    clicked, frac := ProcessScrollBarClicks(scrollRect);

    if(clicked) {
        waveOffset = -lerp(0, maxOffset, frac);
    }

    grabbed, grabOffset := ProcessMiddleClickDragging(graphRect);
    if(grabbed){
        waveOffset += grabOffset;
    }

    waveOffset = clamp(waveOffset, -maxOffset, 0);
    wavePitch = max(wavePitch, 1);

    r.y = startHeight;
    // dont draw the waveform over the buttons
    scissorRect := get_rect(k*3.5, 0, xx window_width, xx window_height);
    set_scissor(scissorRect);

    DrawTimelineTicks(graphRect, wavePitch, k * .01, waveOffset);

    for signals {
        if(it_index == 0 || it_index == signals.count -1) continue;
        DrawSignalVerts(signalVerts[it_index], make_vector3(r.x + k* 3 + waveOffset, r.y, 0), k * .02, wavePitch, waveHeight, true);
        r.y -= k/3;
    }
    

    scissorRect = get_rect(0, 0, xx window_width, xx window_height);
    set_scissor(scissorRect);

    // width label;
    label_theme: Label_Theme;
    label_theme.alignment = .Left;
    label_theme.text_color = .{.9, .5, .5, 1};

    label(r, tprint("total: %", totalWidth), *label_theme);

    center := vec3(k*3.5 + graphWidth / 2, r.y + waveHeight * .75, 0);
 
    slider_theme: Slider_Theme;
    slider_theme.foreground.font = button_font;



    DrawRect(scrollRect, Vector4.{0, 0.4, 0, 1} );
    DrawScrollBar(center, totalWidth, graphWidth, waveOffset, waveHeight);



    r.y -= k /2;
    slider(r, *wavePitch, 1.0, 100.0, 1.0, *slider_theme, "pitch");
    r.y -= k /2;
    slider(r, *waveHeight, 0.0, 100.0, 1.0, *slider_theme, "height");
    r.y -= k /2;
    slider(r, *waveOffset, -maxOffset, 0, 10.0, *slider_theme, "offset");



/*
    
    checkbox_theme: Checkbox_Theme;
    checkbox_theme.font = button_font; // @Cleanup: We have to manually set a font for now.

    radio_theme: Checkbox_Theme;
    radio_theme.font = button_font; // @Cleanup: We have to manually set a font for now.
    radio_theme.is_radio_button = true;

    r = get_rect(4*k, 1.8*k, 2*k, xx button_font.character_height);
    old_y := r.y;

    // Check Boxes:
    vertical_pad := r.h * .35;
    for * groceries {
        pressed := base_checkbox(r, it.name, it.should_get, *checkbox_theme, it_index);
        it.should_get ^= pressed;
        r.y -= button_font.character_height + vertical_pad;
    }

    // Radio Buttons:
    r = get_rect(6*k, old_y, 2*k, xx button_font.character_height);
    for spells {
        selected := (current_spell == it_index);
        pressed := base_checkbox(r, it, selected, *radio_theme, it_index);
        if pressed current_spell = it_index;
        
        r.y -= button_font.character_height + vertical_pad;
    }

    r = get_rect(8*k, old_y + 5 * (button_font.character_height + vertical_pad), 2*k, xx button_font.character_height);


    //
    // Text Input stuff:
    //

    text_theme: Text_Input_Theme;
    text_theme.font = button_font;
    
    r = get_rect(1*k, 4*k, 5*k, button_font.character_height*1.35);
    input_a.rect = r;
    draw(*input_a.input, r, *text_theme);

    text_theme.alignment = .Center;
    r.y -= button_font.character_height * 1.5;
    input_b.rect = r;
    draw(*input_b.input, r, *text_theme);

    text_theme.alignment = .Right;
    r.y -= button_font.character_height * 1.5;
    input_c.rect = r;
    draw(*input_c.input, r, *text_theme);

    // The teas:
    r = get_rect(3*k, 7*k, 3*k, button_font.character_height*1.35);
    // r.y -= button_font.character_height * 1.5;
    input_teas.rect = r;
    text_theme.alignment = .Left;
    draw(*input_teas.input, r, *text_theme);
    
    //
    // Slider:
    //

    // Float value:
 
    r = get_rect(7*k, 7*k, 3*k, button_font.character_height*1.35);
    slider(r, *slider_float_value, 0.0, 60.0, 3.0, *slider_theme, "", "fps");

    // Integer value:
    r.y -= r.h * 1.2;
    slider(r, *slider_int_value, 0, 10, 1, *slider_theme, "number ");


    button_height := window_height * .03;
    
    //
    // Dropdown stuff.
    //
    {
        r = get_rect(13.8*k, 4.1*k, 2.2*k, button_height);
        dropdown_theme := *default_overall_theme.dropdown_theme;

        // The 'dropdown' function causes a popup to be created, which
        // gets rendered at the end of the frame when we call draw_popups().
        // The theme and choices array must remain valid until after that time!
        // The 'current_theme' pointer also needs to remain pointing at valid memory
        // until after that time, as that is when it will be changed.
        dropdown(r, awesome_theme_names, *current_theme, dropdown_theme);
    }

    //
    // Color Picker stuff.
    //
    {
        r = get_rect(13.8*k, .03*k, 3*k, 4*k);
        color_picker_theme := *default_overall_theme.color_picker_theme;
        applied := color_picker(r, *picked_color, color_picker_theme);
    }

    //
    // Slidable Region stuff.
    //

    {
        r = get_rect(7*k, 1*k, 2*k, 5*k);
        
        theme := default_overall_theme.slidable_region_theme;
        theme.orientation = .VERTICAL;
        theme.first_\background.shape.rounding_flags   = Rectangle_Shape.Rounding_Flags.NORTHEAST | .NORTHWEST;
        theme.second_background.shape.rounding_flags   = Rectangle_Shape.Rounding_Flags.SOUTHEAST | .SOUTHWEST;
        theme.first_\background.shape.roundedness_type = .RELATIVE_TO_WIDTH;
        theme.second_background.shape.roundedness_type = .RELATIVE_TO_WIDTH;

        state, left_or_top, right_or_bottom, divider := slidable_region(r, *theme);
        {
            xpad := em(1, button_font);
            ypad := .8 * button_font.character_height;

            orig_s := cut_top(left_or_top, ypad);
            junk, s := cut_left(orig_s, xpad);
            
            //
            // Using type_info, we can very quickly generate some checkboxes for
            // any enum_flags type. The loop below is the only code needed!
            //
            info := type_info(Damage_Resistance);
            stride := button_font.character_height + vertical_pad;            
            s.h = stride;
            s.y -= stride;
            for name: info.names {
                value := cast(Damage_Resistance) info.values[it_index];

                checkbox_flags(s, name, *damage_resistance, value, *checkbox_theme, xx value);
                s.y -= stride;
            }
        }
        
            
        switch_to_bottom_rect(state);
        
        {
            // s := get_rect(8*k, 1*k, 5*k, 2*k);
            s := right_or_bottom;
            
            theme := default_overall_theme.slidable_region_theme;
            theme.orientation = .HORIZONTAL;
            theme.divider_theme.rectangle_shape.frame_thickness_type = .RELATIVE_TO_WIDTH;
            theme.divider_theme.rectangle_shape.roundedness_type     = .RELATIVE_TO_WIDTH;

            // Disable drawing the background, since we are already inside a background that is fine.
            theme.first_background .color.w  = 0;
            theme.second_background.color.w = 0;
            theme.first_background .frame_color.w = 0;
            theme.second_background.frame_color.w = 0;

            state, left_or_top, right_or_bottom, divider := slidable_region(s, *theme);
            switch_to_bottom_rect(state);

            {
                //
                // Scrollable Region stuff.
                //

                {
//                    r = get_rect(10.5*k, 4*k, 1.8*k, 3*k);
                    region, inside := begin_scrollable_region(right_or_bottom);

                    NUM_BUTTONS :: 30;
                    // button_height = floor(inside.w * .22 + .5);

                    // @Incomplete: Add the scrolling offset when we have it.
                    // @Incomplete: Scroll value is in pixels, what happens if the screen changes resolution?
                    s := inside;
                    s.y = s.y + s.h - button_height;
                    s.h = button_height;
                    s.y += scroll_value;
                    button_theme.label_theme.alignment = .Center;
                    button_theme.font = null;
                    
                    for 1..NUM_BUTTONS {
                        text := tprint("Button %", it);
                        pressed := button(s, text, *button_theme, it);

                        if  it != NUM_BUTTONS  {
                            s.y -= floor(button_height * 1.1 + 0.5);  // Just so r.y is in the right place for end_scrollable_region().
                        }
                    }

                    end_scrollable_region(region, s.x + s.w, s.y, *scroll_value);
                }
            }
            
            finish(state);
        }

        finish(state);
    }

    {
        //
 	    // Drag and drop scrollable region.
        // Submitted by Jens Frederich.
 	    //
 	    
 	    theme := default_overall_theme.scrollable_region_theme;
 	    theme.region_background.shape.rounding_flags = 0;
 	    
        r = get_rect(9.5*k, 1*k, 4*k, 5*k);
 	    
 	    region, inside := begin_scrollable_region(r, *theme);
 	    
 	    label_height := window_height * .03;
 	    s := inside;
 	    s.y = s.y + s.h - label_height;
 	    s.h = label_height;
 	    s.y += scroll_value_dragdrop_region;
 	    
 	    label_theme: Label_Theme;
 	    label_theme.alignment = .Left;
 	    label_theme.text_color = .{.9, .5, .5, 1};

 	    if dropped_files {
 	  	    for dropped_files {
 	 	        label(s, it, *label_theme);
 	 	        s.y -= floor(label_height * 1.1 + 0.5);
 	 	    }
        } else {
 	 	    label(s, "Drag/drop files will appear here.", *label_theme);
        }
        
 	    end_scrollable_region(region, s.x + s.w, s.y, *scroll_value_dragdrop_region);
    }


    {
        //
        // Subwindows:
        //

        if !subwindows_initted {
            r := get_rect(7.5*k, 3*k, 4*k, 5*k);
            subwindow_info_text.rect = r;
            subwindow_info_text.draw                 = draw_subwindow_text;
            subwindow_info_text.title_text           = "Text";

            r = get_rect(9.5*k, 3*k, 3*k, 3*k);
            subwindow_info_circle.rect = r;
            subwindow_info_circle.draw                 = draw_subwindow_circle;
            subwindow_info_circle.title_text           = "Circle";
            subwindow_info_circle.fixed_aspect_ratio = 1.0;
            
            subwindows_initted = true;
        }

        theme := default_overall_theme.subwindow_theme;

        if subwindow_info_text.open {  // The Subwindow starts open, but pressing the Close button can close it.
            subwindow_state := add_subwindow(*subwindow_info_text, *theme);
        }

        if subwindow_info_circle.open {  // The Subwindow starts open, but pressing the Close button can close it.
            subwindow_state := add_subwindow(*subwindow_info_circle, *theme);
        }
    }
    
    //
    // Draw the title:
    //

    label_theme: Label_Theme;
    label_theme.font       = signal_font;
    label_theme.text_color = .{.9, .5, .5, 1};
    label_height := title_font.character_height*1.5;
    r = get_rect(0, window_height - label_height, xx window_width, label_height);
    label(r, signalString, *label_theme);

    
    draw_popups();  // This draws Subwindows as well.
    */
    
    //
    // Swap buffers!
    //
    
    Simp.swap_buffers(my_window);
}

draw_subwindow_text :: (r: Rect, data: *void) {
    font := story_font;
    lines := split(TEXT_FIELD_1, "\n");

    K :: .5;
    color := Vector4.{K, K, K, 1};

    xpad := floor(font.default_line_spacing * .5 + .5);
    
    x := r.x + xpad;
    y := r.y + r.h - cast(float) font.default_line_spacing;
    for lines {
        trimmed := trim_right(it, " \t\r\n");
        Simp.draw_text(font, xx x, xx y, trimmed, color);
        y -= cast(float) font.default_line_spacing;
    }
}

draw_subwindow_circle :: (r: Rect, data: *void) {
}

my_init_fonts :: () {
    if !working_directory_set {
        // So that we can load our font, set to path of running executable.
        path := path_strip_filename(get_path_of_running_executable());
        set_working_directory(path);

        working_directory_set = true;
    }
    
    pixel_height := window_height / 24;
    my_font = Simp.get_font_at_size("data", "OpenSans-BoldItalic.ttf", pixel_height);
    assert(my_font != null);

    pixel_height /= 2;
    button_font = Simp.get_font_at_size("data", "OpenSans-BoldItalic.ttf", pixel_height);
    assert(button_font != null);

    pixel_height = window_height / 7;
    title_font = Simp.get_font_at_size("data", "Miama.otf", pixel_height);

    pixel_height = window_height / 30;
    story_font = Simp.get_font_at_size("data", "OpenSans-BoldItalic.ttf", pixel_height);
//    title_font = Simp.get_font_at_size("data", "OpenSans-BoldItalic.ttf", pixel_height);

    pixel_height = window_height / 60;
    signal_font = Simp.get_font_at_size("data", "Inconsolata.otf",  pixel_height);

}

Font :: Simp.Dynamic_Font;

my_font:     *Font;
button_font: *Font;
title_font:  *Font;
story_font:  *Font;
signal_font: *Font;

working_directory_set := false;

Simp  :: #import "Simp";
Input :: #import "Input";

#import "Window_Creation";

#import "Basic";
#import "Math";
#import "System";  // For get_path_of_running_executable. @Cleanup.
#import "String";  // For path_strip_filename. @Cleanup.

