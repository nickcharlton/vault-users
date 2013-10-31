# vault-users Cookbook

Configures system users using a specific JSON data structure encrypted using
[Chef Vault][].

[Chef Vault]: https://github.com/Nordstrom/chef-vault

## Requirements

* `chef-vault`.

Only tested on Ubuntu 12.04.

## Usage

It expects a Chef Vault encrypted vault called `secrets` with an item named `users`.
Then, the data structure should be an array of 'users', like below:

```json
{
    users: [
        {
            "username": "nickcharlton",
            "home": "/home/nickcharlton",
            "shell": "/bin/bash",
            "group": "ops",
            "comment": "Chef Managed User",
            "password": "",
            "authorized_keys": [""]
        }
    ]
}
```

You should create shadow passwords using: `openssl passwd -1 "plain-text-password"`.

Then, add the default cookbook to your run list:

```ruby
run_list [
    "recipe[chef-vault]",
    "recipe[vault-users]"
]
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Copyright (c) Nick Charlton 2013. License: Apache v2.

