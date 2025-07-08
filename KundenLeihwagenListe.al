page 50104 KundenLeihwagenListe
{
    PageType = List;    // Seitentyp wird auf List gesetzt -> tabellarische Übersicht
    ApplicationArea = All;  // In allen Bereichen von Business Central verfügbar
    UsageCategory = Lists; // Gibt bei der Suche an welcher Kategorie es angehört Listen, Verwaltung usw.
    Caption = 'Kunden-Leihwagen-Übersicht';
    SourceTableTemporary = true; // Seite Speichert keine Daten, werden nur angezeigt 
    SourceTable = Leihwagen;    // Verknüpft diese Tabelle 50104 mit der Leihwagen 50101
    // Dadurch wird gewährleistet das man auf Werte aus der Leihwagen Tabelle zugreifen kann und hier nutzen kann

    layout
    {
        area(content)
        {
            group(KundenAuswahl) //Erstellt ein Container mit dem Titel Kunden auswählen (Main Container)
            {
                Caption = 'Kunde auswählen';
                // Dropdown Menü wird erstellt in BC wird ein TableRelation standardmäßig immer zu einem DD-Menü
                field(SelectedCustomer; SelectedCustomer)// VarName; Verknüpfung mit Global Var SelectedCustomer Integer weiter unten
                {
                    Caption = 'Kunde';
                    ApplicationArea = All;
                    // Lädt Kundennr rein und der Lookup von BC lädt automatisch den Namen noch für Userability ein
                    TableRelation = Kunde."Kunden-Nr"; // Sorgt auch dafür das dieses Field ein DropDownMenü wird
                    // OnValidate also wenn was validiert wird da es sich im Field des DD-Menü befindet wird es
                    // getriggert, wenn der User ein Kunden aus dem Dropdown-Menü auswählt
                    trigger OnValidate()
                    begin
                        //Ruf die Funktionen UpdateLeihwagenList() und CalculateTotalCost() nacheinander auf
                        UpdateLeihwagenList(); //Aktualisiert die Liste der Leihwagen basierend auf der ausgewählten Kunden-Nr
                        CalculateTotalCost(); // Berechnet die Summe der Kosten pro Tag für die angezeigten Leihwagen.
                    end;
                }
                field(CustomerName; GetCustomerName)
                {
                    Caption = 'Kundenname';
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            // Neue Section
            repeater(Group)
            {
                field("Leihwagen-Nr"; Rec."Leihwagen-Nr")
                {
                    Editable = false;
                }
                field(Marke; Rec.Marke)
                {
                    Editable = false;
                }
                field(Modell; Rec.Modell)
                {
                    Editable = false;
                }
                field("Kosten pro Tag"; Rec."Kosten pro Tag")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Kunden-Nr"; Rec."Kunden-Nr")
                {
                    Editable = false;
                }
            }

            // Neue Section / Container wird erstellt namens Total
            group(Total)
            {
                Caption = 'Gesamt'; // Überschrift 

                field(TotalCostPerDay; TotalCostPerDay)
                {
                    Caption = 'Gesamtpreis pro Tag';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    // GLOBALE VARIABLEN WERDEN HIER DEFINIERT 
    // ACHTUNG NUR HIER! NICHT WIE IN ANDEREN SPRACHEN (C#, JAVASCRIPT) OBEN 
    var
        SelectedCustomer: Integer;
        SelectedCustomerName: Text[100];
        TotalCostPerDay: Decimal;

    // local = private | procedure = function 
    // private void function UpdateLeihwagenList(){} z.B: in C# oder JavaScript
    local procedure UpdateLeihwagenList()
    // lokale Variable nur innerhalb dieser Prozedur / Funktion verfügbar
    var
        LeihwagenRec: Record Leihwagen; // LeihwagenRec ist die Orginale Leihwagen Record und keine temporäre wie Rec oben
    begin
        Rec.DeleteAll(); // Löscht die Liste bevor neue Daten eingefügt werden
        // Prüft ob SelectedCustomer UNGLEICH (<>) 0 ist -> Kein Kunde ausgewählt
        if SelectedCustomer <> 0 then begin
            // Filtert nur Datensätze, bei denen Kunden-Nr = SelectedCustomer ist.
            // Setzt also ein Filter auf den Record und gibt dann bei FindSet nur noch die Records an die dem Filteralgorithmus entsprechen
            LeihwagenRec.SetRange("Kunden-Nr", SelectedCustomer);
            if LeihwagenRec.FindSet() then // Wenn die Filterung erfolgreich ist und was gefunden wurde DANN
                repeat  // Wiederhole
                    Rec.Init(); // Initialisiert eine neue temporäre Tabelle mit leerem Datensatz
                    Rec.TransferFields(LeihwagenRec); // Kopiert den leeren Datensatz mit den Gefilterten LeihwagenRec
                    Rec.Insert();  // Fügt es nun in Rec
                until LeihwagenRec.Next() = 0; // While schleife geht immer zum nächsten Datensatz bis 0 erreicht ist
        end;
        //* ------------------ WICHTIG: -------------------
        /* Alle funktionen innerhalb einer trigger OnValidation laufen erst ab und am Ende macht Business Central
            CurrPage.Update() d.h. man kann es auch hier schon implementieren der würde trotzdem noch die nächste
            Funktion CalculateTotalCost() abarbeiten und erst danach die Page Updaten aber um es klarer zu 
            strukturieren habe ich es ans ende von CalculateTotalCost getan weil das die letzte Funktion 
            innerhalb der OnValidation ist.
        */
    end;

    local procedure CalculateTotalCost()
    var
        LeihwagenRec: Record Leihwagen;
    begin
        TotalCostPerDay := 0;
        if SelectedCustomer <> 0 then begin
            LeihwagenRec.SetRange("Kunden-Nr", SelectedCustomer);
            if LeihwagenRec.FindSet() then
                repeat
                    TotalCostPerDay += LeihwagenRec."Kosten pro Tag";
                until LeihwagenRec.Next() = 0;
        end;
        CurrPage.Update(false); // Updated die temporäre Tabelle sodass die dem User angezeigt wird 
        // false steht hierbei für keine Änderungen die gespeichert werden sollen da die Tabelle ja temporär ist        
    end;

    // Beim Öffnen der Seite wird das getriggert
    trigger OnOpenPage()
    begin
        // Setzt die Werte auf Default zurück also 0 
        SelectedCustomer := 0;
        TotalCostPerDay := 0;
    end;

    // Return Wert Datentyp -> :Text[100]
    local procedure GetCustomerName(): Text[100]
    var
        CustomerRec: Record Kunde;
    begin
        if SelectedCustomer <> 0 then   // IF SelectedCustomer UNGLEICH 0 Dann                                        
            if CustomerRec.Get(SelectedCustomer) then // IF im PrimaryKey vom CustomerRec die GLEICHE Nummer wie im SelectedCustomer vorkommt DANN
                exit(CustomerRec.Name); // EXIT = Return -> Wert CustomerName oben bei der Variable CustomerName
        exit(''); // Ansonsten Return (Exit) nichts 
    end;
}