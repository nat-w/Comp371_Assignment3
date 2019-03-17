#version 330 core
  
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normals;
layout (location = 2) in vec2 texCoords;

uniform mat4 lightSpaceMatrix;
uniform mat4 Model;
uniform mat4 View;
uniform mat4 Projection;

out vec3 fragment_position;
out vec3 norm;
out vec2 tex_coords;
out vec4 light_space_fragment_position;

void main()
{
    norm = mat3(Model) * normals;
    tex_coords = texCoords;
    fragment_position = mat3(Model) * position;
    light_space_fragment_position = lightSpaceMatrix * vec4(fragment_position, 1.0);
    gl_Position = Projection * View * Model * vec4(position.x, position.y, position.z, 1.0);
}
