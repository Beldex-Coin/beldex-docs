# Accepting Beldex 
## Instructions for the Command-Line Interface
### The Basics
Beldex works a little differently to what you may have become accustomed to from other cryptocurrencies. In the case of a digital currency like Bitcoin and its many derivatives merchant payment systems will usually create a new recipient address for each payment or user.

However, because Beldex has stealth addresses there is no need to have separate recipient addresses for each payment or user, and a single account address can be published. Instead, when receiving payments a merchant will provide the person paying with a `payment ID`.

A payment ID is a hexadecimal string that is 64 characters long, and is normally randomly created by the merchant. An example of a payment ID is:

```
326d381588ae509bcf35fc8ae05abd31ba1ef885ced2e5c1f2180f28845d1f6f
```

To generate a payment ID in `beldex-wallet-cli` run the command:

```
payment_id
```

### Checking for a Payment in beldex-wallet-cli
If you want to check for a payment using `beldex-wallet-cli` you can use the `payments` command followed by the payment ID or payment IDs you want to check:
```
payments <PID_1> [<PID_2> ... <PID_N>]
```

For example:

```
[wallet L6k67F]: payments 4c746dff9f666d6275a60eb6ecbe5078970d5207bc104032f5afa4878eb414e6
                                                             payment                                                         transaction      height               amount     unlock time      addr index
  <4c746dff9f666d6275a60eb6ecbe5078970d5207bc104032f5afa4878eb414e6>  <3fc266d4167060613fba401c65e22e7f01e00045070009b99dd15134b60b47e9>      191878          1.000000000               0               0
[wallet L6k67F]:

```

If you need to check for payments programmatically, then follow the next [section](#checking-for-a-payment-programmatically).

### Receiving a Payment Step-by-Step

- Generate a random 64 character hexadecimal string for the payment

- Communicate the payment ID and Beldex address to the individual who is making payment

- Check for the payment using the "payments" command in beldex-wallet-cli

## Checking for a Payment Programmatically

In order to check for a payment programmatically you can use the `get_payments` or `get_bulk_payments` JSON RPC API calls.

[get_payments](#get_payments): this requires a payment_id parameter with a single payment ID.

[get_bulk_payments](#get_bulk_payments): this is the preferred method, and requires two parameters, payment_ids - a JSON array of payment IDs - and an optional min_block_height - the block height to scan from.

---

#### get_payments

Get a list of incoming payments using a given payment id.

**Alias**: *None.*

**Inputs**:

- *payment_id* - string; Payment ID used to find the payments (16 characters hex).

**Outputs**:

- *payments* - list of:
	- *payment_id* - string; Payment ID matching the input parameter.
	- *tx_hash* - string; Transaction hash used as the transaction ID.
	- *amount* - unsigned int; Amount for this payment.
	- *block_height* - unsigned int; Height of the block that first confirmed this payment.
	- *unlock_time* - unsigned int; Time (in block height) until this payment is safe to spend.
	- *subaddr_index* - subaddress index:
		- *major* - unsigned int; Account index for the subaddress.
		- *minor* - unsigned int; Index of the subaddress in the account.
	- *address* - string; Address receiving the payment; Base58 representation of the public keys.

**Example**:

```
$ curl -X POST http://127.0.0.1:19092/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_payments","params":{"payment_id":"4c746dff9f666d6275a60eb6ecbe5078970d5207bc104032f5afa4878eb414e6"}}' -H 'Content-Type: application/json'
{
  "id": "0",
  "jsonrpc": "2.0",
  "result": {
    "payments": [{
      "address": "LTyHcisBFCGQ6nU3D8wtMj5nr9yZfVBqE5pzrKQak5abBPFMx21r5V57UT33hzzzyLA8yaJFyrcj7iJwiQ8Z1zPeK1a7tpo",
      "amount": 1000000000000,
      "block_height": 127606,
      "payment_id": "4c746dff9f666d6275a60eb6ecbe5078970d5207bc104032f5afa4878eb414e6",
      "subaddr_index": {
        "major": 0,
        "minor": 0
      },
      "tx_hash": "3fc266d4167060613fba401c65e22e7f01e00045070009b99dd15134b60b47e9",
      "unlock_time": 0
    }]
  }
}
```

---
#### get_bulk_payments

Get a list of incoming payments using a given payment id, or a list of payments ids, from a given height. This method is the preferred method over `get_payments` because it has the same functionality but is more extendable. Either is fine for looking up transactions by a single payment ID.

**Alias**: *None.*

**Inputs**:

- payment_ids - array of: string; Payment IDs used to find the payments (16 characters hex).
- min_block_height - unsigned int; The block height at which to start looking for payments.

**Outputs**:

- *payments* - list of:
	- *payment_id* - string; Payment ID matching one of the input IDs.
	- *tx_hash* - string; Transaction hash used as the transaction ID.
	- *amount* - unsigned int; Amount for this payment.
	- *block_height* - unsigned int; Height of the block that first confirmed this payment.
	- *unlock_time* - unsigned int; Time (in block height) until this payment is safe to spend.
	- *subaddr_index* - subaddress index:
		- *major* - unsigned int; Account index for the subaddress.
		- *minor* - unsigned int; Index of the subaddress in the account.
	- *address* - string; Address receiving the payment; Base58 representation of the public keys.

**Example**:

```
$ curl -X POST http://127.0.0.1:19092/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_bulk_payments","params":{"payment_ids":["60900e5603bf96e3"],"min_block_height":"120000"}}' -H 'Content-Type: application/json'
{
  "id": "0",
  "jsonrpc": "2.0",
  "result": {
    "payments": [{
      "address": "LTyHcisBFCGQ6nU3D8wtMj5nr9yZfVBqE5pzrKQak5abBPFMx21r5V57UT33hzzzyLA8yaJFyrcj7iJwiQ8Z1zPeK1a7tpo",
      "amount": 1000000000000,
      "block_height": 127606,
      "payment_id": "4c746dff9f666d6275a60eb6ecbe5078970d5207bc104032f5afa4878eb414e6",
      "subaddr_index": {
        "major": 0,
        "minor": 0
      },
      "tx_hash": "3fc266d4167060613fba401c65e22e7f01e00045070009b99dd15134b60b47e9",
      "unlock_time": 0
    }]
  }
}
```
---

It is important to note that the amounts returned are in base Beldex units and not in the display units normally used in end-user applications. Also, since a transaction will typically have multiple outputs that add up to the total required for the payment, the amounts should be grouped by the `tx_hash` or the `payment_id` and added together. Additionally, as multiple outputs can have the same amount, it is imperative not to try and filter out the returned data from a single `get_bulk_payments` call.

Before scanning for payments it is useful to check against the daemon RPC API (the `get_info` RPC call) to see if additional blocks have been received. Typically you would want to then scan only from that received block on by specifying it as the `min_block_height` to `get_bulk_payments`.

#### Programatically Scanning for Payments

- Get the current block height from the daemon, only proceed if it has increased since our last scan.

- Call the `get_bulk_payments` RPC API call with our last scanned height and the list of all payment IDs in our system

- Store the current block height as our last scanned height

- Remove duplicates based on transaction hashes we have already received and processed

## Sources

[https://ww.getmonero.org/get-started/accepting/](https://ww.getmonero.org/get-started/accepting/)

[https://src.getmonero.org/resources/developer-guides/wallet-rpc.html](https://src.getmonero.org/resources/developer-guides/wallet-rpc.html)