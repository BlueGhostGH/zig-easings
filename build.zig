const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const test_step = b.step("test", "Run tests");
    const run_step = b.step("run", "Run example.");

    const tests = b.option(bool, "tests", "Run unit tests") orelse false;

    if (tests) {
        const exe = b.addTestExe("easings-zig-test", "easings.zig");
        exe.setTarget(target);
        exe.setBuildMode(mode);
        exe.install();

        const exe_run = exe.run();
        exe_run.step.dependOn(b.getInstallStep());
        run_step.dependOn(&exe_run.step);
    }

    const test_runner = b.addTest("easings.zig");
    test_runner.setBuildMode(mode);
    test_runner.setTarget(target);
    test_step.dependOn(&test_runner.step);
}

pub fn getPackage(name: []const u8) std.build.Pkg {
    return std.build.Pkg{
        .name = name,
        .path = .{ .path = std.fs.path.dirname(@src().file).? ++ "/easings.zig" },
        .dependencies = null, // null by default, but can be set to a slice of `std.build.Pkg`s that your package depends on.
    };
}
