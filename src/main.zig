// Zig program to create a window using CSFML (C Simple and Fast Multimedia Library)
// Written in zig by Renan Lucas
const std = @import("std");
// Import CSFML C bindings
const c = @cImport({
    @cInclude("CSFML/System.h");
    @cInclude("CSFML/Graphics.h");
    @cInclude("CSFML/Window.h");
});
// Import C standard library headers
const stdio = @cImport({
    @cInclude("stdio.h");
});
// CSFML window mode configuration
const mode = c.sfVideoMode{
    .size = c.sfVector2u{ .x = 800, .y = 600 },
    .bitsPerPixel = 0,
};

// Title for the window
const title = " Zig CSFML Window";
// Main function to create a window using CSFML
pub fn main() void {
    // Initialize CSFML Window
    const window = c.sfRenderWindow_create(mode, title, c.sfResize | c.sfClose, 0, 0);
    // Check if the window was created successfully
    if (window == null) {
        std.debug.print("==> Failed to create window\n", .{});
    } else {
        std.debug.print("==> Window created successfully\n", .{});
    }
    // Main event loop to keep the window open
    while (c.sfRenderWindow_isOpen(window)) {
        var event: c.sfEvent = undefined;
        while (c.sfRenderWindow_pollEvent(window, &event)) {
            if (event.type == c.sfEvtClosed) {
                std.debug.print("==> Window closed event received\n", .{});
                c.sfRenderWindow_close(window);
            }
        }
        c.sfRenderWindow_clear(window, c.sfBlack);
        c.sfRenderWindow_display(window);
    }
    c.sfRenderWindow_destroy(window);
}
