pragma solidity ^0.5.0;

// Import the ERC-721 token interface
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract VehicleOwnership is ERC721 {

    // Define the struct for a vehicle
    struct Vehicle {
        string make;
        string model;
        uint year;
        address owner;
    }

    // Define the mapping from vehicle ID to vehicle struct
    mapping(uint => Vehicle) public vehicles;

    // Define the array for all vehicle IDs
    uint[] public vehicleIds;

    // Function to add a new vehicle
    function addVehicle(string memory _make, string memory _model, uint _year) public {
        // Create a new vehicle struct
        Vehicle memory newVehicle = Vehicle(_make, _model, _year, msg.sender);

        // Add the vehicle to the mapping
        vehicles[vehicleIds.length] = newVehicle;

        // Mint a new token for the vehicle and assign it to the minter
        _mint(msg.sender, vehicleIds.length);

        // Add the vehicle ID to the array
        vehicleIds.push(vehicleIds.length);
    }

    // Function to transfer ownership of a vehicle
    function transferOwnership(uint _vehicleId, address _newOwner) public {
        // Ensure the caller is the current owner of the vehicle
        require(vehicles[_vehicleId].owner == msg.sender, "Only the current owner can transfer ownership");

        // Transfer ownership of the vehicle to the new owner
        vehicles[_vehicleId].owner = _newOwner;

        // Transfer the token for the vehicle to the new owner
        _transfer(_vehicleId, _newOwner);
    }
}
