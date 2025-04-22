// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Easy creation of ERC20 tokens.
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Not stricly necessary for this case, but let us use the modifier onlyOwner
// https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable
import "@openzeppelin/contracts/access/Ownable.sol";

// This allows for granular control on who can execute the methods (e.g., 
// the validator); however it might fail with our validator contract!
// https://docs.openzeppelin.com/contracts/5.x/api/access#AccessControl
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

// import "hardhat/console.sol";


// Import BaseAssignment.sol
import "../BaseAssignment.sol";

contract CensorableToken is ERC20, Ownable, BaseAssignment, AccessControl {

    mapping(address => bool) public isBlacklisted;
    event Blacklisted(address indexed account);
    event UnBlacklisted(address indexed account);

    // Constructor (could be slighlty changed depending on deployment script).
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply, address _initialOwner)
        BaseAssignment(0x8452E41BA34aC00458B70539264776b2a379448f)
        ERC20(_name, _symbol)
        Ownable(_initialOwner)
    {

        _mint(_initialOwner, 10 * 10 ** decimals());

        address validator = getValidator();
        _mint(validator, 10 * 10 ** decimals());

        modifier onlyOwnerOrValidator() {
        require(
            msg.sender == owner() || isValidator(msg.sender),"Not owner or validator");
        _;
    }

       // Hint: get the decimals rights!
       // See: https://docs.soliditylang.org/en/develop/units-and-global-variables.html#ether-units 
    }


    // Function to blacklist an address
    function blacklistAddress(address _account) {
       
       // Note: if AccessControl fails the validation on the (not)UniMa Dapp
       // you can use a simpler approach, requiring that msg.sender is 
       // either the owner or the validator.
       // Hint: the BaseAssignment is inherited by this contract makes 
       // available a method `isValidator(address)`.

    }

    // Function to remove an address from the blacklist
    function unblacklistAddress(address _account) {
    
    }

    // More functions as needed.

    // There are multiple approaches here. One option is to use an
    // OpenZeppelin hook to intercepts all transfers:
    // https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#ERC20

    // This can also help:
    // https://blog.openzeppelin.com/introducing-openzeppelin-contracts-5.0
}
