shader_type spatial;

uniform float cutoff : hint_range(0.0, 1.0) = 1.0;
uniform bool reverse = false;

uniform float height_min = 0.0;
uniform float height_max = 5.0;

uniform sampler2D waterfall_texture;   // your PNG
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);

varying float local_h;

void vertex() {
    local_h = (VERTEX.y - height_min) / (height_max - height_min);
}

void fragment() {
    // Direction control
    float h = reverse ? (1.0 - local_h) : local_h;
    float mask = step(cutoff, h);

    // Sample texture
    vec2 uv = UV * uv_scale + uv_offset;
    vec4 tex = texture(waterfall_texture, uv);

    // Apply masking
    ALBEDO = tex.rgb * mask;
    ALPHA  = tex.a * mask;
}
