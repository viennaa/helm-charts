{
    "bindings": [],
    "exchanges": [],
    "parameters": [],
    "permissions": [
        {
            "configure": ".*",
            "read": ".*",
            "user": "monitoring",
            "vhost": "/",
            "write": ".*"
        },
        {
            "configure": ".*",
            "read": ".*",
            "user": "guest",
            "vhost": "/",
            "write": ".*"
        },
        {
            "configure": ".*",
            "read": ".*",
            "user": "rabbitmq",
            "vhost": "/",
            "write": ".*"
        },
        {
            "configure": ".*",
            "read": ".*",
            "user": "admin",
            "vhost": "/",
            "write": ".*"
        }
    ],
    "policies": [],
    "queues": [],
    "topic_permissions": [],
    "users": [
        {
            "hashing_algorithm": "rabbit_password_hashing_sha256",
            "name": "rabbitmq",
            "password_hash": "OAxuIas9uGJlZAxE0HcY4tdBj9TtFBIfmy78SasoISxChpSJ",
            "tags": ""
        },
        {
            "hashing_algorithm": "rabbit_password_hashing_sha256",
            "name": "admin",
            "password_hash": "XziX+am46cLstM+kUq9VEWJAIMeyQEW9F1k0QtQIKQb0T240",
            "tags": "administrator"
        },
        {
            "hashing_algorithm": "rabbit_password_hashing_sha256",
            "name": "guest",
            "password_hash": "gaj3rwrcSw3Mzx5868nEUvqg+3rLe/MTv10uZ55xsx7Um8Xf",
            "tags": "monitoring"
        },
        {
            "hashing_algorithm": "rabbit_password_hashing_sha256",
            "name": "monitoring",
            "password_hash": "rXWaYe7pGEc+GZWg4orNcO/6pOKO06QbmZJibtF8N5lr+/Sh",
            "tags": "monitoring"
        }
    ],
    "vhosts": [
        {
            "name": "/"
        }
    ]
}
