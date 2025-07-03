page 50101 LeihwagenListe
{
    PageType = List;
    SourceTable = Leihwagen;
    ApplicationArea = All;
    Caption = 'Leihwagen';
    CardPageId = LeihwagenKarte;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leihwagen-Nr"; Rec."Leihwagen-Nr") { }
                field(Marke; Rec.Marke) { }
                field(Modell; Rec.Modell) { }
                field("Kosten pro Tag"; Rec."Kosten pro Tag") { }
                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Status = Rec.Status::Frei then begin
                            Rec."Kunden-Nr" := 0;
                            Rec.Modify();
                        end;
                        CurrPage.Update();
                    end;
                }
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    ApplicationArea = All;
                    ToolTip = 'Kunde auswählen';
                    Editable = Rec.Status = Rec.Status::Vermietet;

                }
            }
        }
    }
}