// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    // Address of the admin
    address public admin;

    // Mapping for updater roles
    mapping(address => bool) public isUpdater;

    // Struct to hold shipment details
    struct Shipment {
        string description;
        string status;
        address lastUpdatedBy;
    }

    // Mapping to store shipments by ID
    mapping(uint256 => Shipment) public shipments;

    // Event emitted when a shipment's status is updated
    event ShipmentStatusUpdated(
        uint256 indexed shipmentId,
        string status,
        address indexed updatedBy
    );

    // Event emitted when an updater is added or removed
    event UpdaterRoleChanged(address indexed updater, bool isAuthorized);

    // Modifier to restrict access to admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not an admin");
        _;
    }

    // Modifier to restrict access to updaters
    modifier onlyUpdater() {
        require(isUpdater[msg.sender], "Not an updater");
        _;
    }

    // Constructor to set the deployer as the admin
    constructor() {
        admin = msg.sender;
    }

    // Function to add an updater (only callable by admin)
    function addUpdater(address updater) external onlyAdmin {
        isUpdater[updater] = true;
        emit UpdaterRoleChanged(updater, true);
    }

    // Function to remove an updater (only callable by admin)
    function removeUpdater(address updater) external onlyAdmin {
        isUpdater[updater] = false;
        emit UpdaterRoleChanged(updater, false);
    }

    // Function to update a shipment's status (only callable by updaters)
    function updateShipmentStatus(
        uint256 shipmentId,
        string calldata description,
        string calldata status
    ) external onlyUpdater {
        shipments[shipmentId] = Shipment({
            description: description,
            status: status,
            lastUpdatedBy: msg.sender
        });

        emit ShipmentStatusUpdated(shipmentId, status, msg.sender);
    }

    // Function to view shipment details
    function getShipment(uint256 shipmentId)
        external
        view
        returns (
            string memory description,
            string memory status,
            address lastUpdatedBy
        )
    {
        Shipment memory shipment = shipments[shipmentId];
        return (shipment.description, shipment.status, shipment.lastUpdatedBy);
    }
}
