// Author: Renan Lucas
// CSFML Zig Example - Window Management
// Creates a graphical window with basic event handling

const std: type = @import("std");

// Import CSFML graphics bindings
const c: type = @cImport({
    @cInclude("CSFML/Graphics.h");
    @cInclude("CSFML/System.h");
    @cInclude("CSFML/Window.h");
});

// Configure video mode settings
// Window configuration
const WINDOW_WIDTH: comptime_int = 800;
const WINDOW_HEIGHT: comptime_int = 600;
const WINDOW_TITLE: *const [12:0]u8 = "CSFML in Zig";

const mode = c.sfVideoMode{
    .size = c.sfVector2u{
        .x = WINDOW_WIDTH,
        .y = WINDOW_HEIGHT,
    },
};

// Null-terminated string for title
const title: *const [12:0]u8 = WINDOW_TITLE;

// Public Main function
pub fn main() void {
    // Create window with improved error handling
    const window = c.sfRenderWindow_create(mode, title, c.sfResize | c.sfClose, 0, 0) orelse {
        std.debug.print("==> Window creation failed\n", .{});
        return;
    };
    std.debug.print("==> Window created successfully\n", .{});

    // Create basic shape
    const shape = c.sfCircleShape_create() orelse {
        std.debug.print("==> Failed to create shape\n", .{});
        return;
    };
    c.sfCircleShape_setRadius(shape, 50);
    c.sfCircleShape_setFillColor(shape, c.sfGreen);
    c.sfCircleShape_setPosition(shape, .{ .x = WINDOW_WIDTH / 2 - 50, .y = WINDOW_HEIGHT / 2 - 50 });

    // Main event/render loop
    while (c.sfRenderWindow_isOpen(window)) {
        var event: c.sfEvent = undefined;

        // Process events with full switch
        while (c.sfRenderWindow_pollEvent(window, &event)) {
            if (event.type == c.sfEvtClosed) {
                std.debug.print("==> Window closed event received\n", .{});
                c.sfRenderWindow_close(window);
            }
        }

        // Rendering pipeline
        c.sfRenderWindow_clear(window, c.sfColor_fromRGB(30, 30, 30));
        c.sfRenderWindow_drawCircleShape(window, shape, 0);
        c.sfRenderWindow_display(window);

        // Limit frame rate
        c.sfSleep(c.sfMilliseconds(16)); // ~60 FPS
    }

    // Cleanup window resources
    c.sfRenderWindow_destroy(window);
    c.sfCircleShape_destroy(shape);
}
