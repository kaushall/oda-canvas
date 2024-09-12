@UC014 @UC014-F003 @SECRET-MANAGEMENT
Feature: Secrets Management - Alice-2 can access Alice-1 secrets

    Background:
    Given a baseline 'productcatalog-v1beta3-sman' package installed as release 'alice'
    And the 'alice-vault-inspector' component instance has a deployment status of 'Complete'

    Scenario: Secrets created before scale up are accessible by all instances
    When the 'alice-vault-inspector' component creates the secret 'foo' with value 'bar' 
    And the 'alice-vault-inspector' component is scaled up to 2 instances
    Then the 'alice-vault-inspector' component instance 1 can read the secret 'foo' and its value is 'bar'
    And the 'alice-vault-inspector' component instance 2 can read the secret 'foo' and its value is 'bar'

    Scenario: Secrets created by instances are accessible by all instances.
    When the 'alice-vault-inspector' component is scaled up to 2 instances
    And the 'alice-vault-inspector' instance 1 component creates the secret 'foo1' with value 'bar1'
    And the 'alice-vault-inspector' instance 2 component creates the secret 'foo2' with value 'bar2'
    Then the 'alice-vault-inspector' component instance 1 can read the secret 'foo1' and its value is 'bar1'
    And the 'alice-vault-inspector' component instance 2 can read the secret 'foo1' and its value is 'bar1'
    And the 'alice-vault-inspector' component instance 1 can read the secret 'foo2' and its value is 'bar2'
    And the 'alice-vault-inspector' component instance 2 can read the secret 'foo2' and its value is 'bar2'

    Scenario: Secrets created by instances still exist after scale down.
    Given the 'alice-vault-inspector' component is scaled up to 2 instances
    And the 'alice-vault-inspector' instance 1 component creates the secret 'foo1' with value 'bar1'
    And the 'alice-vault-inspector' instance 2 component creates the secret 'foo2' with value 'bar2'
    When the 'alice-vault-inspector' component is scaled down to 1 instance
    Then the 'alice-vault-inspector' component can read the secret 'foo1' and its value is 'bar1'
    And the 'alice-vault-inspector' component can read the secret 'foo2' and its value is 'bar2'
