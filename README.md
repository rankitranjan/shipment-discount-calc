# Shipment discount calculation module.

This Shipment discount calculator is built with Ruby.


## How to Run?

From the root folder of the shipment-discount-calc, issue

### Bundler

```bash
# To install gems
bundle install 
```

### Running the application

```bash
rake run PATH_TO_THE_FILE

# If you have input file in the root folder of the project called input.txt, issue 

rake run input.txt

```

## Running Tests

To run the complete test suite, issue

```bash
rake test
```
To Run a single file test, issue

```bash
rake test TEST=test/transaction_test.rb    
```

## Architecture overview

<img width="579" alt="Screenshot 2021-07-01 at 08 27 19" src="https://user-images.githubusercontent.com/10682375/124058029-382d7080-da46-11eb-9f27-2dcf5751c1d3.png">

### To add a new rule.

Go to `lib/rule_sets.rb`

add new rule there and call the rule inside `price/discount.rb` wilth required parameters under 

Price::Discount.apply_rules_and_get_discount_price

