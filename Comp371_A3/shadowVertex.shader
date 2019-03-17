#version 330 core
layout (location = 0) in vec3 position;

uniform mat4 lightSpaceMatrix;
uniform mat4 shadowModel;

void main()
{
    gl_Position = lightSpaceMatrix * shadowModel * vec4(position, 1.0);
}
