const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zstbi",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    const cflags: []const []const u8 = &.{};
    lib.addCSourceFile(.{
        .file = .{ .path = "stb_image.c" },
        .flags = cflags,
    });
    lib.installHeader("stb_image.h", "stb_image.h");
    lib.installHeader("stb_image_write.h", "stb_image_write.h");

    const zstbi = b.addModule("zstbi", .{ .root_source_file = .{ .path = "src/root.zig" } });
    zstbi.linkLibrary(lib);
    b.installArtifact(lib);
}
