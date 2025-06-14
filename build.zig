const std = @import("std");

pub fn build(b: *std.Build) void {
    // Set the build mode to ReleaseFast
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseFast,
    });
    // Set the build mode
    const exe = b.addExecutable(.{
        .name = "zig_csfml",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    // Link libc
    exe.linkLibC();
    // Link CSFML libraries
    exe.linkSystemLibrary("csfml-graphics");
    exe.linkSystemLibrary("csfml-window");
    exe.linkSystemLibrary("csfml-system");
    // "Zig build run" command
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the Zig CSFML application");
    run_step.dependOn(&run_cmd.step);
    // Install the executable
    b.installArtifact(exe);
}
