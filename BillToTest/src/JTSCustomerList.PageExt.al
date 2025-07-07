pageextension 50000 "JTS Customer List" extends "Customer List"
{
    layout
    {

    }

    actions
    {
        addlast("&Customer")
        {
            action("RelatedCustomers")
            {
                ApplicationArea = All;
                Caption = 'Related Customers';
                Image = CustomerList;
                ToolTip = 'View related customers';
                RunObject = page "Customer List";
                RunPageLink = "Bill-to Customer No." = field("No.");
                RunPageMode = View;
            }

        }
    }
}