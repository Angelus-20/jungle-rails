describe('Home Page', () => {
  beforeEach(() => {

    cy.visit('/');
  });

  it('should add a product to the cart and update the cart count', () => {
    cy.get('.btn:contains("Add")').first().click({force: true});
    cy.wait(2000);
    cy.get('.cart-count').should('contain', '1');

    // cy.get('.btn:contains("Add")').first().click({force: true});
    // cy.wait(2000);
    // cy.get('.cart-count').should('contain', '2');
  });
});
