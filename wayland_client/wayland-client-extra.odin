package wayland_client

wl_registry_add_listener :: proc(
	wl_registry: ^wl_registry,
	listener: ^wl_registry_listener,
	data: rawptr,
) -> int {
	return wl_proxy_add_listener(cast(^wl_proxy)wl_registry, cast(^rawptr)listener, data)
}

wl_display_get_registry :: proc(wl_display: ^wl_display) -> ^wl_registry {
	interface: wl_interface
	registry: ^wl_proxy
	registry = wl_proxy_marshal_flags(
		cast(^wl_proxy)wl_display,
		1,
		&wl_registry_interface,
		wl_proxy_get_version(cast(^wl_proxy)wl_display),
		0,
		nil,
	)
	return cast(^wl_registry)registry
}

wl_registry_bind :: proc(
	wl_registry: ^wl_registry,
	name: uint,
	interface: ^wl_interface,
	version: uint,
) -> rawptr {
	id: ^wl_proxy
	id = wl_proxy_marshal_flags(
		cast(^wl_proxy)wl_registry,
		0,
		interface,
		version,
		0,
		name,
		interface.name,
		version,
		nil,
	)
	return cast(rawptr)id
}

wl_compositor_create_surface :: proc(wl_compositor: ^wl_compositor) -> ^wl_surface {
	id: ^wl_proxy
	id = wl_proxy_marshal_flags(
		cast(^wl_proxy)wl_compositor,
		0,
		&wl_surface_interface,
		wl_proxy_get_version(cast(^wl_proxy)wl_compositor),
		0,
		nil,
	)
	return cast(^wl_surface)id
}

shell_get_shell_surface :: proc(wl_shell: ^wl_shell, surface: ^wl_surface) -> ^wl_shell_surface {
	id: ^wl_proxy
	id = wl_proxy_marshal_flags(
		cast(^wl_proxy)wl_shell,
		0,
		&wl_shell_surface_interface,
		wl_proxy_get_version(cast(^wl_proxy)wl_shell),
		0,
		nil,
		surface,
	)
	return cast(^wl_shell_surface)id
}

shell_surface_set_toplevel :: proc(wl_shell_surface: ^wl_shell_surface) {
	wl_proxy_marshal_flags(
		cast(^wl_proxy)wl_shell_surface,
		3,
		nil,
		wl_proxy_get_version(cast(^wl_proxy)wl_shell_surface),
		0,
	)
}

