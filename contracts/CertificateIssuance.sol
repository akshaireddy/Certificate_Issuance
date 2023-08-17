// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateIssuance {

    address public owner; // Address of the contract owner
    uint256 public certificateId; // Incremental ID for certificates
    
    // Struct to represent a certificate
    struct Certificate {
        uint256 id;
        address recipient;
        string courseName;
        uint256 issueDate;
        bool isRevoked;
    }

    // Mapping from certificate ID to Certificate
    mapping(uint256 => Certificate) public certificates;

    // Event to log certificate issuance
    event CertificateIssued(uint256 indexed id, address indexed recipient, string courseName, uint256 issueDate);

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        certificateId = 1;
    }

    // Function to issue a certificate
    function issueCertificate(address _recipient, string memory _courseName) public onlyOwner {
        certificates[certificateId] = Certificate({
            id: certificateId,
            recipient: _recipient,
            courseName: _courseName,
            issueDate: block.timestamp,
            isRevoked: false
        });
        
        emit CertificateIssued(certificateId, _recipient, _courseName, block.timestamp);
        
        certificateId++;
    }

    // Function to revoke a certificate
    function revokeCertificate(uint256 _certificateId) public onlyOwner {
        require(certificates[_certificateId].id == _certificateId, "Certificate not found");
        require(!certificates[_certificateId].isRevoked, "Certificate is already revoked");

        certificates[_certificateId].isRevoked = true;
    }

    // Function to verify if a certificate is valid
    function verifyCertificate(uint256 _certificateId) public view returns (bool) {
        return (
            certificates[_certificateId].id == _certificateId &&
            !certificates[_certificateId].isRevoked
        );
    }
}
