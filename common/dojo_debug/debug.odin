package dojo_debug

// Tiny tracking-allocator session wrapper for demos and exercise mains.
// Learner-owned helper: read it, understand it, then use it everywhere.
//
// Usage sketch (in your demo proc, debug builds):
//   sess := dojo_debug.tracked_begin()
//   defer dojo_debug.tracked_end(&sess)
//   ... your allocations ...
//
// Ownership: the session wraps the allocator that was in `context`
// at `tracked_begin` time. `tracked_end` reports and destroys the
// tracker. Allocations still live must be freed BEFORE `tracked_end`.

import "core:fmt"
import "core:mem"

Tracked :: struct {
	track:   mem.Tracking_Allocator,
	backing: mem.Allocator,
	active:  bool,
}

// Install a tracking allocator over the current context allocator.
// The caller's `context.allocator` is replaced; restore happens in tracked_end.
tracked_begin :: proc(backing: mem.Allocator = context.allocator) -> Tracked {
	s: Tracked
	s.backing = backing
	mem.tracking_allocator_init(&s.track, s.backing)
	s.active = true
	context.allocator = mem.tracking_allocator(&s.track)
	return s
}

// Report leaks / bad frees, destroy the tracker, restore backing allocator.
// Returns true when the session is clean (no leaks, no bad frees).
tracked_end :: proc(s: ^Tracked) -> bool {
	if s == nil || !s.active {
		return true
	}
	ok := true

	if len(s.track.allocation_map) > 0 {
		fmt.eprintf("LEAKS: %d allocation(s) not freed:\n", len(s.track.allocation_map))
		for _, v in s.track.allocation_map {
			fmt.eprintf("  %v bytes at %v\n", v.size, v.location)
		}
		ok = false
	} else {
		fmt.println("tracking: no leaks")
	}

	if len(s.track.bad_free_array) > 0 {
		fmt.eprintf("BAD FREES: %d\n", len(s.track.bad_free_array))
		for b in s.track.bad_free_array {
			fmt.eprintf("  bad free at %v\n", b.location)
		}
		ok = false
	} else {
		fmt.println("tracking: no bad frees")
	}

	context.allocator = s.backing
	mem.tracking_allocator_destroy(&s.track)
	s.active = false
	return ok
}
