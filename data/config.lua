return {
    debug = true, -- enable debug for ox_lib zones
    zones = {     -- Poly zone reference to docs https://overextended.dev/ox_lib/Modules/Zones/Shared
        {
            points = {
                vec3(-591.15808105469, -1087.8620605469, 22.0),
                vec3(-563.33447265625, -1087.8508300781, 22.0),
                vec3(-563.26678466797, -1045.1898193359, 22.0),
                vec3(-618.20904541016, -1044.2902832031, 22.0),
                vec3(-617.80517578125, -1079.7291259766, 22.0),
                vec3(-599.44097900391, -1079.6105957031, 22.0)
            },
            thickness = 9.0,
            group = 'catcafe',
            dutyType = 'both', -- 'enter', 'exit', 'both' -- Enter is if you want it to toggle duty on when entering but not off exiting, exit is the opposite, both is when you want it to toggle duty on both entering and exiting
        },
    },
}
