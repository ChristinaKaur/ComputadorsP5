### Programa realitzat per Christina Kaur Krishan ###
 
# Al exacutar s'han de passar al programa els valors (com a la primera pràctica) #
# Ex: .\separa.ps1 a DADES.txt 4                                                 #

# Comprovar si s'han entrat més de 3 paràmetres abans de començar a fer res i inicialitzar variables
If ($args[3] -ne $null) { 
    Write-Host "NOMÉS ES PERMET ENTRAR UN MÀXIM DE TRES PARÀMETRES"
	Exit 1
}

# Guardantels paràmetres que s'han entrat per teclat al exacutar el programa 
$format = $args[0]
$nom_fitxer = $args[1]
$fitxer = "$PSScriptRoot\$nom_fitxer"

# Cromprovar els 3 primers paràmetres
If ($format -ne 'a' -and $format -ne 's') { # Comprovar primer paràmetre
    Write-Host "EL PRIMER PARÀMETRE HA DE SER 'a' O 's'"
    Exit 1
}
elseif (!(Test-Path $fitxer)) { # Comprovar segon paràmetre
    Write-Host "EL SEGON PARÀMETRE HA DE SER UN FITXER EXISTENT AL DIRECTORI ACTUAL"
	Exit 1
}
elseif ($args[2] -ne $null) {  # Comprovar si s'ha entrat un tercer paràmetre o no
    If ((!($args[2] -is [int])) -or ($args[2] -le 0)) {
        Write-Host "EL TERCER PARÀMETRE HA DE SER UN ENTER SUPERIOR A ZERO"
        Exit 1
    }
    else {
        $quantitat = [int]$args[2]
    }
}

function resultat_final($n_parag) {
    Write-Host "S'han processat $n_parag paràgrafs."    
}

# Llegir $fitxer i crear els fitxers corresponents als paràmetres entrats
function Separa_n($contingut) { 
    # Llegeix fitxer fins que s'hagin creat $quantitat fitxers 
    $i = 0
    while ($i -ne $quantitat*3) {
        $titol_fitxer = $contingut[$i]
        
        $contador 
        while (Test-Path "$PSScriptRoot\$titol_fitxer.txt") {
            $contador++
            $titol_fitxer = $contingut[$i]+$contador
        }
        
        $text = $contingut[$i+1]
        $salt = $contingut[$i+2]

        $text+$salt | Add-Content "$PSScriptRoot\$titol_fitxer.txt"
        $n_parag++
        $i+=3
    }
    resultat_final($n_parag)
}

function Separa_tot($contingut) {
    # Llegeix tot el fitxer 
    $i = 0
    while ($contingut[$i] -ne $Null) {
        $titol_fitxer = $contingut[$i]
        
        $contador = 0
        while (Test-Path "$PSScriptRoot\$titol_fitxer.txt") {
            $contador++
            $titol_fitxer = $contingut[$i]+$contador
        }
        
        $text = $contingut[$i+1]
        $salt = $contingut[$i+2]

        $text+$salt | Add-Content "$PSScriptRoot\$titol_fitxer.txt"
        $n_parag++
        $i+=3
    }
    resultat_final($n_parag)
}

function Agrupa_n($contingut) {
    # Llegeix fitxer fins que s'hagin creat $quantitat fitxers 
    $i = 0
    while ($i -ne $quantitat*3) {
        $titol_fitxer = $contingut[$i]
        $text = $contingut[$i+1]
        $salt = $contingut[$i+2]

        $text+$salt | Add-Content "$PSScriptRoot\$titol_fitxer.txt"
        $n_parag++
        $i+=3
    }
    resultat_final($n_parag)
}

function Agrupa_tot($contingut) {
    # Llegeix tot el fitxer
    $i = 0
    while ($contingut[$i] -ne $Null) {
        $titol_fitxer = $contingut[$i]
        $text = $contingut[$i+1]
        $salt = $contingut[$i+2]

        $text+$salt | Add-Content "$PSScriptRoot\$titol_fitxer.txt"
        $n_parag++
        $i+=3
    }
    resultat_final($n_parag)
}

# Programa principal
$contingut = Get-Content $fitxer
$n_parag = 0

If ($format -eq 's') { # Crear fitxers amb títols repetits (ex: "HOLA", "HOLA1", "HOLA2", ...)
    If ($quantitat -ne $null) { 
        Separa_n($contingut)
    }
    else { 
        Separa_tot($contingut)
    }
}
else { # elseif ($format -eq 'a'), Crear fitxers sense títols repetits
    If ($quantitat -ne $null) { 
        Agrupa_n($contingut)
    }
    else { 
        Agrupa_tot($contingut)
    }
}