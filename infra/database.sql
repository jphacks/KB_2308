CREATE TABLE user_profiles (
    id UUID NOT NULL, -- ユーザー特定のためのID; auth.users.id
    user_id VARCHAR(255) NOT NULL DEFAULT '',
    name VARCHAR(255) NOT NULL DEFAULT '',
    image_url VARCHAR(255) NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE,
    UNIQUE (user_id)
);

CREATE TABLE user_locations (
    id UUID NOT NULL, -- ユーザー特定のためのID; auth.users.id
    location_name VARCHAR(255) NOT NULL DEFAULT '',
    is_custom BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE
);

CREATE TYPE follow_status AS ENUM ('requesting', 'pending', 'friend');

CREATE TABLE follows (
    user_id UUID NOT NULL,
    target_user_id UUID NOT NULL,
    status follow_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    PRIMARY KEY (user_id, target_user_id),
    FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE,
    FOREIGN KEY (target_user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
