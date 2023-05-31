## Energy Marketplace Contract

The Energy Marketplace contract allows users to create and trade energy offers in a decentralized marketplace.

### Contract Structure

The contract includes the following:

- `EnergyType`: An enumeration representing different types of energy (Solar, Wind, Hydro).
- `EnergyOffer`: A struct that represents an energy offer with the following properties:
  - `id`: A unique identifier for the energy offer.
  - `seller`: The address of the seller who created the offer.
  - `energyType`: The type of energy being offered.
  - `energyAmount`: The amount of energy available for sale.
  - `pricePerUnit`: The price per unit of energy.
  - `isActive`: A boolean indicating whether the offer is active or not.

- `energyOffers`: A mapping that stores the energy offers, with the offer ID as the key.
- `nextEnergyOfferId`: A variable that keeps track of the next energy offer ID to be assigned.

### Events

The contract emits the following events:

- `EnergyOfferCreated`: Triggered when a new energy offer is created.
- `EnergyOfferCanceled`: Triggered when an energy offer is canceled by the seller.
- `EnergyBought`: Triggered when energy is bought from an offer.

### Functions

The contract provides the following functions:

- `createEnergyOffer`: Allows a user to create a new energy offer by specifying the energy type, energy amount, and price per unit.
- `cancelEnergyOffer`: Allows the seller to cancel their energy offer.
- `buyEnergy`: Allows a user to buy energy from an active offer by specifying the offer ID and desired energy amount. The function transfers the payment to the seller and updates the energy offer accordingly.

### Modifiers

The contract does not include any modifiers.

### License

The contract is licensed under the MIT License. Refer to the SPDX-License-Identifier at the top of the code for more details.
