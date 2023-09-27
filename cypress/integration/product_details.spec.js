describe('Home Page', () => {
  beforeEach(() => {

    cy.visit('/');
  });

  it('should click on a product partial and navigate to the product detail page', () => {
  
    cy.get('article').first().find('a').click();
    cy.wait(2000);

    cy.get('article.product-detail').should('exist');

    cy.go('back');
  });
});
