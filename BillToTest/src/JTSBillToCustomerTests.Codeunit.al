codeunit 50000 "JTS BillToCustomerTests"
{

    Subtype = Test;
    TestPermissions = Disabled;

    var
        LibraryRandom: Codeunit "Library - Random";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
        Initialized: Boolean;

    [Test]
    procedure TestBillToCustomerFromCustomerList()
    var
        Customer: Record Customer;
        RelatedCustomer: Record Customer;
        CustomerList: TestPage "Customer List";
        RelatedCustomerList: TestPage "Customer List";
        ExpectedRecords: Integer;
        CountedRecords: Integer;
    begin
        Initialize();
        // [GIVEN] A new customer
        LibrarySales.CreateCustomer(Customer);

        // [GIVEN] X Customers with the same Bill-to Customer No.
        ExpectedRecords := Create_X_RelatedCustomers(RelatedCustomer, Customer);

        // [WHEN] The Related Customer action is clicked
        CustomerList.OpenView();
        CustomerList.GoToRecord(Customer);
        RelatedCustomerList.Trap();
        CustomerList.RelatedCustomers.Invoke();
        CountedRecords := CountRelatedCustomers(RelatedCustomerList);

        // [THEN] The Related Customers has the expected number of records
        Assert.AreEqual(ExpectedRecords, CountedRecords, 'The number of related customers is not as expected.');
    end;

    [Test]
    procedure TestBillToCustomerFromCustomerCard()
    var
        Customer: Record Customer;
        RelatedCustomer: Record Customer;
        CustomerCard: TestPage "Customer Card";
        RelatedCustomerList: TestPage "Customer List";
        ExpectedRecords: Integer;
        CountedRecords: Integer;
    begin
        Initialize();
        // [GIVEN] A new customer
        LibrarySales.CreateCustomer(Customer);

        // [GIVEN] X Customers with the same Bill-to Customer No.
        ExpectedRecords := Create_X_RelatedCustomers(RelatedCustomer, Customer);

        // [WHEN] The Related Customer action is clicked
        CustomerCard.OpenView();
        CustomerCard.GoToRecord(Customer);
        RelatedCustomerList.Trap();
        CustomerCard.RelatedCustomers.Invoke();

        CountedRecords := CountRelatedCustomers(RelatedCustomerList);

        // [THEN] The Related Customers has the expected number of records
        Assert.AreEqual(ExpectedRecords, CountedRecords, 'The number of related customers is not as expected.');
    end;

    local procedure Create_X_RelatedCustomers(RelatedCustomer: Record Customer; Customer: Record Customer): Integer
    var
        RecordsToCreate: Integer;
        i: Integer;
    begin
        RecordsToCreate := LibraryRandom.RandIntInRange(2, 15);
        for i := 1 to RecordsToCreate do begin
            LibrarySales.CreateCustomer(RelatedCustomer);
            RelatedCustomer."Bill-to Customer No." := Customer."No.";
            RelatedCustomer.Modify();
        end;

        exit(RecordsToCreate);
    end;

    local procedure Initialize()

    begin
        if Initialized then
            exit;

        LibraryRandom.SetSeed(CurrentDateTime().Time().Millisecond());
        Initialized := true;
    end;

    local procedure CountRelatedCustomers(var RelatedCustomerList: TestPage "Customer List") Records: Integer
    begin
        RelatedCustomerList.First();

        Records := 1;
        while RelatedCustomerList.Next() do begin
            Records += 1;
        end;

        RelatedCustomerList.Close();

        exit(Records);
    end;
}
