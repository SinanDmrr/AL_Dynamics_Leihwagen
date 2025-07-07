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
                field("Leihwagen-Nr"; Rec."Leihwagen-Nr") { Editable = false; }
                field(Marke; Rec.Marke) { Editable = false; }
                field(Modell; Rec.Modell) { Editable = false; }
                field("Kosten pro Tag"; Rec."Kosten pro Tag") { Editable = false; }
                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        // Bei Optionswerten also Dropdown Werten (Frei, Vermietet) wird mit :: geprüft 
                        if Rec.Status = Rec.Status::Frei then begin //Wenn der Aktuell Status Frei ist DANN
                            Rec."Kunden-Nr" := 0; // Kundennummer 0 setzen
                            Rec.Modify();   // Speichert Kundenummer 0 direkt in der Tabelle
                        end;
                        CurrPage.Update();  // Updatet nun die Seite damit der User auch die neue Version sieht
                    end;
                }
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    ApplicationArea = All;
                    ToolTip = 'Kunde auswählen';
                    // Editable = true kennen wir hier wird es mit eine Bedingung verknüpft WENN
                    // Rec.Status gleich Rec.Status::Vermitet ist also wenn Option nicht Frei sondern Vermietet ist
                    // DANN ist das Feld Editierar und dadurch das wir in der Table sagen das das Feld ein 
                    // TableRelation = Kunde."Kunden-Nr"; werden die Kundennummern aus der Tabelle Kunde rein geladen ins DD-Menü
                    Editable = Rec.Status = Rec.Status::Vermietet;
                }
            }
        }
    }
}