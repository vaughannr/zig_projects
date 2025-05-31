const std = @import("std");
const testing = std.testing;

pub const SimulationResults = struct {
    time_of_flight: f64,
    max_altitude: f64,
    range: f64,
};

pub fn simulateProjectile(initial_velocity: f64, launch_angle: f64) SimulationResults {
    const g = 9.81; // Acceleration due to gravity in m/s^2

    // Initialize positions and velocities
    var x: f64 = 0; // horizontal position
    var y: f64 = 0; // vertical position
    const vx: f64 = initial_velocity * std.math.cos(launch_angle); // horizontal velocity
    var vy: f64 = initial_velocity * std.math.sin(launch_angle); // vertical velocity
    var t: f64 = 0; // time
    const dt: f64 = 0.001; // time step for simulation
    var max_altitude: f64 = 0; // maximum altitude reached

    // Simulation loop: run until the projectile has hit the ground (y < 0)
    while (y >= 0) {
        //Update positions
        x += vx * dt;
        y += vy * dt;

        // Check for maximum altitude
        if (y > max_altitude) {
            max_altitude = y;
        }

        // Update vertical velocity with gravity
        vy -= g * dt;

        // Update time
        t += dt;
    }

    return SimulationResults{
        .time_of_flight = t,
        .max_altitude = max_altitude,
        .range = x,
    };
}
