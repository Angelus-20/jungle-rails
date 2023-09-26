describe('Home Page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  // it('should click on a product partial and navigate to the product detail page', () => {
  //   cy.get('article').first().find('a').click();

  //   cy.get('.product-detail-title').should('exist');
  //   cy.get('.product-detail-price').should('exist');

  //   cy.go('back');
  // });
});
