# Amenitiz
Technical Evaluation Amenitiz Problem to Solve

## Ruby versions
3.0.3

## Data seed
`rails db:seed`

## Server
`rails s`

## Tests
`rspec`

## Structure of database
database_structure.drawio
db/schema.rb

## Explanation
Sorry for the setup I made, I was trying to play around with some tools during the development and that was a mistake. It took me too much time. Anyway, hopefully it isn't too bad.

Next time I would use basic FormObjects with ActiveRecord support for the as simple task as this.

What for sure is missing is a better configuration for discount rules. I would use maybe a creator but it isn't so important for this task. Anyway I hate magic-string and numbers like in `app/units/orders/add_product/subactions/discount.rb` or enums `app/models/discount_rule.rb`

I didn't care about Frontend side because it looks like u don't care too.

If u have any additional wishes to do here sth I don't mind.

You can run `rails s` and because there are not many views it is easy to navigate. The tests are there so it should be easy to play around.