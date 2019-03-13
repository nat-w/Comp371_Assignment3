#version 330 core

out vec4 result;

uniform vec3 object_color;
uniform vec3 view_position;
uniform vec3 light_colors[4];
uniform vec3 light_positions[4];
uniform vec3 light_color;
uniform vec3 light_position;
uniform int multi_light;
uniform int shadow;

in vec3 fragment_position;
in vec3 norm;

void main()
{
    float ambient_strength = 0.25f;
    float diffuse_strength_coef = 0.75f;
    float specular_strength_coef = 1.0f;

    vec3 final_color = object_color;

    if (multi_light == 1) {
        vec3 colors[4];
        for (int i = 0; i < 4; i++) {
            //Ambient
            vec3 ambient = ambient_strength * light_colors[i];

            //Diffuse
            vec3 light_direction = normalize(light_positions[i] - fragment_position);
            float diffuse_strength = max(dot(normalize(norm), light_direction), 0.0f);
            vec3 diffuse = diffuse_strength * light_colors[i];
            diffuse *= diffuse_strength_coef;

            //Specular
            vec3 view_direction = normalize(view_position - fragment_position);
            vec3 reflect_light_direction = reflect(-light_direction, normalize(norm));
            float specular_strength = pow(max(dot(reflect_light_direction, view_direction), 0.0f),32);
            vec3 specular = specular_strength * light_colors[i];
            specular *= specular_strength_coef;

            colors[i] = (specular + diffuse + ambient) * object_color;
        }
        final_color = colors[0] + colors[1] + colors[2] + colors[3];
    }
    else if (shadow == 1) {
        // Ambient
        vec3 ambient = ambient_strength * light_color;

        // Diffuse
        vec3 light_direction = normalize(light_position - fragment_position);
        float diffuse_strength = max(dot(normalize(norm), light_direction), 0.0f);
        vec3 diffuse = diffuse_strength * light_color;
        diffuse *= diffuse_strength_coef;

        // Specular
        vec3 view_direction = normalize(view_position - fragment_position);
        vec3 reflect_light_direction = reflect(-light_direction, normalize(norm));
        float specular_strength = pow(max(dot(reflect_light_direction, view_direction), 0.0f),32);
        vec3 specular = specular_strength * light_color;
        specular *= specular_strength_coef;

        final_color = (specular + diffuse + ambient) * object_color;
    }
    result = vec4(final_color, 1.0f);
}
