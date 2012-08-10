# HabtmGenerator


## Installation

Add this line to your application's Gemfile:

    gem 'habtm_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install habtm_generator

## Usage


```bash
rails generate habtm user post
```

This will generate a migration, for:
* creating table "posts\_users" with user\_id, post\_id, no primary key
* index on both columns

And will copy the "has\_and\_belongs\_to\_many :model" into both models (near the top of the models)

This process is reversible (with ``rails destroy habtm model1 model2``).

## Potential Caveats

* Namespaced models will not work
