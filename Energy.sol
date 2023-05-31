// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnergyMarketplace {
    enum EnergyType { Solar, Wind, Hydro }
    
    struct EnergyOffer {
        uint256 id;
        address seller;
        EnergyType energyType;
        uint256 energyAmount;
        uint256 pricePerUnit;
        bool isActive;
    }
    
    mapping (uint256 => EnergyOffer) public energyOffers;
    uint256 public nextEnergyOfferId;
    
    event EnergyOfferCreated(uint256 id, address seller, EnergyType energyType, uint256 energyAmount, uint256 pricePerUnit);
    event EnergyOfferCanceled(uint256 id);
    event EnergyBought(uint256 id, address buyer, uint256 energyAmount);
    
    function createEnergyOffer(EnergyType _energyType, uint256 _energyAmount, uint256 _pricePerUnit) public {
        require(_energyAmount > 0, "Energy amount must be greater than zero.");
        require(_pricePerUnit > 0, "Price per unit must be greater than zero.");
        
        uint256 id = nextEnergyOfferId++;
        energyOffers[id] = EnergyOffer(id, msg.sender, _energyType, _energyAmount, _pricePerUnit, true);
        
        emit EnergyOfferCreated(id, msg.sender, _energyType, _energyAmount, _pricePerUnit);
    }
    
    function cancelEnergyOffer(uint256 _id) public {
        require(energyOffers[_id].seller == msg.sender, "Only the seller can cancel this energy offer.");
        
        energyOffers[_id].isActive = false;
        emit EnergyOfferCanceled(_id);
    }
    
    function buyEnergy(uint256 _id, uint256 _energyAmount) public payable {
        require(energyOffers[_id].isActive == true, "This energy offer is not active.");
        require(energyOffers[_id].energyAmount >= _energyAmount, "Not enough energy available.");
        require(msg.value == energyOffers[_id].pricePerUnit * _energyAmount, "Incorrect amount sent.");
        
        energyOffers[_id].energyAmount -= _energyAmount;
        payable(energyOffers[_id].seller).transfer(msg.value);
        
        emit EnergyBought(_id, msg.sender, _energyAmount);
    }
}
