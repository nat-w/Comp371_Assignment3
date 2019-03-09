#version 330 core

out vec4 result;

uniform vec3 object_color;
uniform vec3 view_position;
uniform vec3 light_color1;
uniform vec3 light_color2;
uniform vec3 light_color3;
uniform vec3 light_color4;
uniform vec3 light_position1;
uniform vec3 light_position2;
uniform vec3 light_position3;
uniform vec3 light_position4;

in vec3 fragment_position;
in vec3 norm;

void main()
{
    vec3 color;

    // ambient
    float ambient_strength = 0.25f;
    vec3 ambient = ambient_strength * vec3(1.0f, 1.0f, 1.0f);

    // diffuse
    float diffuse_strength = 0.75f;
    vec3 light_direction1 = normalize(light_position1 - fragment_position);
    vec3 light_direction2 = normalize(light_position2 - fragment_position);
    vec3 light_direction3 = normalize(light_position3 - fragment_position);
    vec3 light_direction4 = normalize(light_position4 - fragment_position);
    vec3 diffuse = diffuse_strength * light_color1 * light_color2 * light_color3 * light_color4;

    // specular
    vec3 view_direction = normalize(view_position - fragment_position);
    vec3 reflect_light_direction1 = reflect(-light_direction1, normalize(norm));
    vec3 reflect_light_direction2 = reflect(-light_direction2, normalize(norm));
    vec3 reflect_light_direction3 = reflect(-light_direction3, normalize(norm));
    vec3 reflect_light_direction4 = reflect(-light_direction4, normalize(norm));
    float specular_strength = 1.0f;
    vec3 specular = specular_strength * light_color1;

    color = (specular + diffuse + ambient) * object_color;
    result = vec4(color, 1.0f);
} 
