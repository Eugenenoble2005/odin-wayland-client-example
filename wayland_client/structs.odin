package wayland_client
import "core:c"

wl_display :: struct {}
wl_connection :: struct {}
wl_proxy :: struct {}
wl_event_queue :: struct {}
wl_registry :: struct {}
wl_registry_listener :: struct {
	global:        proc(
		data: rawptr,
		wl_registry: ^wl_registry,
		name: uint,
		interface: cstring,
		version: uint,
	),
	global_remove: proc(data: rawptr, wl_registry: ^wl_registry, name: uint),
}
wl_message :: struct {}
wl_compositor :: struct {}
wl_interface :: struct {
	name: cstring,
}
wl_surface :: struct {}
wl_shell :: struct {}
wl_shell_surface :: struct {}

