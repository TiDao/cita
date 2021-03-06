pragma solidity 0.4.24;

import "./Error.sol";

/// @title A common contract about admin
/// @author ["Rivtower Technologies <contact@rivtower.com>"]
contract Admin is Error {

    address public admin;

    event AdminUpdated(
        address indexed _account,
        address indexed _old,
        address indexed _sender
    );

    modifier onlyAdmin {
        if (isAdmin(msg.sender))
            _;
        else return;
    }

    constructor(address _account) public {
        admin = _account;
    }

    /// @notice Update the admin
    ///         Be careful to use it. TODO update the permissions of admin
    /// @param _account Address of the admin
    /// @return true if successed, otherwise false
    function update(address _account)
        external
        onlyAdmin
        returns (bool)
    {
        if (_account == admin) {
            return true;
        }
        emit AdminUpdated(_account, admin, msg.sender);
        admin = _account;
        address auth_addr = address(0xffffffffffffffffffffffffffffffffff020006);
        bytes4 funcId = bytes4(keccak256("updateAdmin(address)"));
        return auth_addr.call(funcId,_account);
    }

    /// @notice Check the account is admin
    /// @param _account The address to be checked
    /// @return true if it is, otherwise false
    function isAdmin(address _account)
        public
        returns (bool)
    {
        if (_account == admin) {
            return true;
        }
        emit ErrorLog(ErrorType.NotAdmin, "Not the admin account");
    }
}
