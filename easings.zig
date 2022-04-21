const std = @import("std");
const testing = std.testing;

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    var result = add(3, 7);

    try testing.expect(result == 10);
}
