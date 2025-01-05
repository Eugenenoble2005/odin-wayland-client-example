package wayland_client
import "core:c"
when ODIN_OS == .Linux do foreign import wl_client "system:libwayland-client.so"

@(default_calling_convention = "c")
foreign wl_client {
	wl_display_connect :: proc(name: cstring) -> ^wl_display ---
	wl_display_disconnect :: proc(wl_display: ^wl_display) ---

	wl_proxy_add_listener :: proc(wl_proxy: ^wl_proxy, implementation: ^rawptr, data: rawptr) -> int ---

	wl_proxy_marshal_flags :: proc(proxy: ^wl_proxy, opcode: uint, interface: ^wl_interface, version: uint, flags: uint, #c_vararg args: ..any) -> ^wl_proxy ---

	wl_proxy_get_version :: proc(wl_proxy: ^wl_proxy) -> uint ---

	wl_display_dispatch :: proc(wl_display: ^wl_display) -> c.int ---
	wl_display_roundtrip :: proc(wl_display: ^wl_display) -> c.int ---

	wl_registry_interface: wl_interface
	wl_compositor_interface: wl_interface
	wl_surface_interface: wl_interface
	wl_shell_surface_interface: wl_interface

}

