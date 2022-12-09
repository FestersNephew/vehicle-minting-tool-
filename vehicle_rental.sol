pragma solidity ^0.8.0;

// Define the vehicle token contract
contract VehicleToken {
  // Define the token's name and symbol
  string public name = "Vehicle Token";
  string public symbol = "VT";

  // Define the VIN number for the vehicle
  string public vin;

  // Define the owner of the vehicle token
  address public owner;

  // Define the token's total supply
  uint256 public totalSupply;

  // Define the mapping for the token's balance for each address
  mapping(address => uint256) public balanceOf;

  // Define the event for when the vehicle token is transferred
  event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  // Constructor function to mint the token and set the owner
  constructor() public {
    // Set the initial total supply of the token
    totalSupply = 1;

    // Set the owner of the token to the contract creator
    owner = msg.sender;

    // Set the initial balance of the owner
    balanceOf[msg.sender] = 1;
  }

  // Function to mint additional tokens
  function mint(address to, uint256 value) public {
    // Check if the caller is the owner of the token
    require(msg.sender == owner, "Only the owner can mint new tokens.");

    // Mint the new tokens and update the total supply and balance
    totalSupply += value;
    balanceOf[to] += value;
  }

  // Function to transfer the token
  function transfer(address to, uint256 value) public {
    // Check if the sender has enough balance to transfer
    require(balanceOf[msg.sender] >= value, "Insufficient balance.");

    // Transfer the token by updating the balance of the sender and recipient
    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;

    // Emit the Transfer event
    emit Transfer(msg.sender, to, value);
  }

  // Function to set the VIN number for the vehicle
  function setVIN(string memory _vin) public {
    // Check if the caller is the owner of the token
    require(msg.sender == owner, "Only the owner can set the VIN number.");

    // Set the VIN number for the vehicle
    vin = _vin;
  }

  // Function to rent the vehicle
  function rent(address to, uint256 value) public {
    // Check if the caller is the owner of the token
    require(msg.sender == owner, "Only the owner can rent the vehicle.");

    // Transfer the token to the renter
    transfer(to, value);
  }
}
