# About

Hello! This is a payment application which allows user to send money to different countries.

## Payment application

![My wallets](/public/readme/MyWalletsPage.png)

The application has three pages:

- **My wallets** - list of user wallets.
- **New payment** - new payment form.
- **History** - history of payments.

You can assume that there is one user of this application only. Authentication and authorization are not needed.

The application doesn't make payments itself, it uses special payment gateway API for that.

![My wallets](/public/readme/PaymentFlow.png)

### Page "My wallets"

There are two predefined wallets: one for USD and one for EUR currency.
User can not spend more money than he has on his wallets.
Only payment application knows about user balance and wallets.
Payment gateway API doesn't limit how many payments can be made and how much money can be paid.

### Page "New payment"

For each payment user must choose:

- A **wallet** to send money from. The payment will be made in the wallet's currency.
- A destination **country**. The selected country must support payments in the selected currency.
- A money **amount** to send (positive decimal number).
- Any number of additional **fields** specific for the selected country.

The application can get the list of available countries (with supported currencies and required additional fields) from the payment gateway API. It must request this list periodically because it is subject for change.

### Page "History"

There must be a table with following columns: Date, Wallet, Country, Amount. The table must contain all payments user made sorted by date.

## Payment gateway API

The payment gateway API has two endpoints:

- `[GET] /payment_gateway/countries` - returns the list of available countries in JSON format.
- `[POST] /payment_gateway/create_payment` - accepts payment parameters in JSON format and creates new payment.

### [GET] /payment_gateway/countries

The response format:
```
[
  {
    "name": "Spain",
    "currencies": ["EUR"],
    "fields": [
      {
        "id" => "recipient_name",
        "name" => "Recipient name"
      },
      ...
    ]
  },
  ...
]
```

### [POST] /payment_gateway/create_payment

The request format:
```
{
  id: "1",
  country: "Spain",
  currency: "EUR",
  amount: 100.34,
  fields: [
    {
      id: "recipient_name",
      value: "John Smith"
    },
    ...
  ]
}
```
`id` must be a unique payment identifier.

## Your task

...

## Getting started

...
