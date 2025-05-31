const std = @import("std");
const phys = @import("simple_trajectory_lib");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    if (args.len != 3) {
        try stdout.print("Usage: {s} <initial_velocity (m/s)> <launch_angle (degrees)>\n", .{args[0]});
        return error.InvalidArguments;
    }

    // Convert the input arguments into a floating-point value.
    const initial_velocity = try std.fmt.parseFloat(f64, args[1]);
    const launch_angle_degrees = try std.fmt.parseFloat(f64, args[2]);
    const launch_angle_radians = std.math.pi * launch_angle_degrees / 180.0;

    // Run the projectile motion simulation.
    const results = phys.simulateProjectile(initial_velocity, launch_angle_radians);

    try stdout.print("Simulation Results:\n", .{});
    try stdout.print("Time of Flight: {d:.3} seconds\n", .{results.time_of_flight});
    try stdout.print("Maximum Altitude: {d:.3} meters\n", .{results.max_altitude});
    try stdout.print("Horizontal Range: {d:.3} meters\n", .{results.range});
}
