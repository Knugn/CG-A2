// Vertex shader
#version 150
#extension GL_ARB_explicit_attrib_location : require

layout(location = 0) in vec4 a_position;
layout(location = 1) in vec3 a_normal;

out vec3 v_color;

uniform mat4 u_mvp; // ModelViewProjection matrix
uniform mat4 u_mv; // ModelView matrix
uniform vec3 u_light_position; // The position of your light source

void main()
{
    gl_Position = u_mvp * vec4(a_position.xyz, 1.0);

	//v_color = vec3(0.0, 1.0, 0.0);
	//v_color = a_normal * 0.5 + 0.5;

	// Transform the vertex position to view space (eye coordinates)
	vec3 position_eye = vec3(u_mv * a_position);

	// Calculate the view-space normal
	vec3 N = normalize(mat3(u_mv) * a_normal);

	// Calculate the view-space light direction
	vec3 L = normalize(u_light_position - position_eye);

	// Calculate the diffuse (Lambertian) reflection term
	float diffuse = max(0.0, dot(N, L));

	// Multiply the diffuse reflection term with the surface color
	v_color = diffuse * vec3(0.0, 1.0, 0.0);
}
