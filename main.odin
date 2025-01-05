package main
import "core:fmt"
import "core:os"
import "wayland_client"
//globals
display: ^wayland_client.wl_display = nil
compositor: ^wayland_client.wl_compositor = nil
surface: ^wayland_client.wl_surface
shell: ^wayland_client.wl_shell = nil
shell_surface: ^wayland_client.wl_shell_surface

global_registry_handler :: proc(
	data: rawptr,
	registry: ^wayland_client.wl_registry,
	id: uint,
	interface: cstring,
	version: uint,
) {
	fmt.printf("Got a registry event for  %s with id %d \r\n", interface, id)
	if (interface == "wl_compositor") {
		compositor =
		cast(^wayland_client.wl_compositor)wayland_client.wl_registry_bind(
			registry,
			id,
			&wayland_client.wl_compositor_interface,
			1,
		)
	}
}

global_registry_remover :: proc(data: rawptr, wl_registry: ^wayland_client.wl_registry, id: uint) {
	fmt.printf("Got a registry losing event for %d", id)
}

registry_listener := wayland_client.wl_registry_listener {
	global_registry_handler,
	global_registry_remover,
}

main :: proc() {
	display := wayland_client.wl_display_connect(nil)
	if display == nil {
		fmt.println("Could not connect to display")
		return
	}

	fmt.println("Connected to Wayland display!")
	registry := wayland_client.wl_display_get_registry(display)
	wayland_client.wl_registry_add_listener(registry, &registry_listener, nil)

	fmt.println("Dispath")
	wayland_client.wl_display_dispatch(display)
	wayland_client.wl_display_roundtrip(display)

	if compositor == nil {
		fmt.println("Cannot find compositor")
		os.exit(1)
	} else {
		fmt.println("Found Compositor")
	}

	surface = wayland_client.wl_compositor_create_surface(compositor)
	if surface == nil {
		fmt.println("Cannot create surface")
		os.exit(1)
	}
	fmt.println("Surface created")

	if shell == nil {
		fmt.println("havent got a wayland shell")
		os.exit(1)
	}
	shell_surface = wayland_client.shell_get_shell_surface(shell, surface)
	if shell_surface == nil {
		fmt.println("cannot create shell surface")
	}
	fmt.println("Created shell surface")

	wayland_client.shell_surface_set_toplevel(shell_surface)
	//disconnect from display
	wayland_client.wl_display_disconnect(display)
	fmt.println("Disconnected from wayland display")
}

