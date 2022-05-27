RD /S /Q "_tempzip"
MD "_tempzip"
MD "_tempzip\bin"
MD "_tempzip\bin\Providers"
MD "_tempzip\RESOURCES"

COPY ..\*.aspx _tempzip\RESOURCES\*.*

COPY ..\Install\AWSWebFarmCachingProvider.dnn _tempzip\AWSWebFarmCachingProvider.dnn
COPY ..\license.txt _tempzip\license.txt
COPY ..\releaseNotes.txt _tempzip\releaseNotes.txt

COPY ..\bin\Providers\AccordLMS.Providers.Caching.AWSWebFarmCachingProvider.dll _tempzip\bin\Providers\*.*
COPY ..\bin\Providers\AccordLMS.Providers.Caching.AWSWebFarmCachingProvider.xml _tempzip\bin\Providers\*.*


"%ProgramFiles%\WinRAR\winrar.exe" M -afzip -m5 -r -ep1 _tempzip\Resources.zip  _tempzip\RESOURCES\*.*

RD /S /Q "_tempzip\RESOURCES"

"%ProgramFiles%\WinRAR\winrar.exe" M -afzip -m5 -r -ep1 _tempzip\AccordLMS.01.00.00.AWSWebFarmCachingProvider_Install.zip _tempzip\*.*

COPY _tempzip\AccordLMS.01.00.00.AWSWebFarmCachingProvider_Install.zip .\*.*

RD /S /Q "_tempzip"