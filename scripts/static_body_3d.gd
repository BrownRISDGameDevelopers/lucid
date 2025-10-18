extends StaticBody3D

# this function is called by the viewport manager after a ray is cast
# and it collides on this StaticBody3D (whose parent is a tile)
func on_cube_click():
	get_parent().my_static_body3d_clicked()
