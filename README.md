# Blockchain-project

Supplychain.sol is a solidity contract that has features:
  - Role-Based Access Control:
      Admin Role: The deployer of the contract is the admin by default
      Updater Role: Admin can grant/revoke permissions for specific addresses to update shipment statuses.
  - Shipment Tracking:
      Tracks shipments by unique ID, storing details like description, status, and the last updater's address.
  - Transparency and Auditability:
      Emits events for all updates (ShipmentStatusUpdated) and role changes (UpdaterRoleChanged).
