
USE YaYoBE_Hospital1

create table LegalStatus(
LegalStatusId INT primary key,
LegalStatusColor varchar(10) not null,
LegalStatusVal varchar(10) not null,
[Description] varchar(MAX) NOT NULL
);

Create table Room
(
RoomNo INT primary key,
RoomType varchar(10) NOT NULL,
BuildingNo varchar(10) NOT NULL,
[Floor] TINYint NOT NULL
); 

Create Table BedType
(
BedTypeId TINYINT primary Key,
[Name] varchar(15) NOT NULL,
Description Varchar(MAX) NOT NULL
);

Create table Bed
(
BedNo INT IDENTITY(101,1) primary key,
BedTypeID TINYINT NOT NULL,
BedStatus varchar(10) DEFAULT 'Booked',
RoomNo INT NOT NULL,
foreign key (RoomNo)references Room(RoomNo),
foreign key (BedTypeId)references BedType(BedTypeId)
)

Create table ExamRoom
(
ExamRoomNo varchar(10) primary key,
RoomNo varchar(10) NOT NULL 
)

Create table IPD_Unit
(
IPD_UnitID INT IDENTITY primary key,
[Name] varchar(10) NOT NULL,
[Description] varchar(Max) NOT NULL
)
-- Eg (PCU, ICU, WARD)

Create table PCUType
(
PCUTypeId TINYINT IDENTITY primary key,
[Name] varchar(50) NOT NULL,
[Description] varchar(max) NOT NULL
)

Create table PCU
(
PCU_Id INT IDENTITY PRIMARY KEY,
InpatientId VARCHAR(10) NOT NULL,
IPD_UnitID INT,
PCUTypeId TINYINT,
PCUAdmitDate DATETIME DEFAULT GETDATE(),
PCUDischargeDate date,
[Description] varchar(max),
foreign key (IPD_UnitID) references IPD_Unit(IPD_UnitID),
foreign key (InpatientId) references Inpatient(InpatientId),
foreign key (PCUTypeId) references PCUType(PCUTypeId)
)

Create table ICUType 
(
ICUTypeId TINYINT primary key,
[Name] varchar(50) NOT NULL,
[Description] varchar(max)
)

-- Example SICU=Surgical ICU, TICU=Trauma ICU or Transplant ICU, NICU=Neuro ICU or Neonatal ICU, PICU=Pediatric ICU
-- CVICU=Cardiovascular ICU, CCU=Coronary Care Unit, CICU=Cardiac ICU, BICU=Burn ICU

Create table ICU  
(
ICU_Id INT IDENTITY PRIMARY KEY,
InpatientId VARCHAR(10) NOT NULL,
ICUTypeId TINYINT,
IPD_UnitId INT,
ICUAdmitDate datetime DEFAULT GETDATE(),
ICUDischargeDate datetime,
[Description] varchar(max),
foreign key (IPD_UnitID) references IPD_Unit(IPD_UnitID),
foreign key (InpatientId)  Inpatient(InpatientId),
foreign key (ICUTypeId) references ICUType(ICUTypeId),
)
 
--https://www.doh.wa.gov/ForPublicHealthandHealthcareProviders/HealthcareProfessionsandFacilities/HealthcareAssociatedInfections/HAIReports/TypesofHospitalUnits

Create table WARDType---EXAMPLE  SergicalWard,MedicaWard,LaborWard
(references
WARDTypeId tinyint identity primary key,
[Name] varchar(50) NOT NULL,
Description varchar(max)
)

Create table WARD
(
WARD_Id int IDENTITY PRIMARY KEY,
InpatientId VARCHAR(10) NOT NULL,
IPD_UnitID INT,
WARDTypeId tinyint,
WARDAdmitDate date DEFAULT GETDATE(),
WARDDischargeDate date,
[Description] varchar(max),
foreign key (IPD_UnitID) references IPD_Unit(IPD_UnitID),
foreign key (InpatientId) references Inpatient(InpatientId),
foreign key (WARDTypeId) references WARDType(WARDTypeId)
) 

Create Table InPatient
(
Id INT IDENTITY(1,1) NOT NULL,
InpatientId AS ('InP'+ RIGHT('0000000' + CAST(ID AS VARCHAR(7)), 7)) PERSISTED PRIMARY KEY,
-- PatientAdmissionId INT, 
-- PatientId int not null,Replaced by MRNo
MRNo VARCHAR (12),
BedNo int not null, 
AdmDiag varchar(Max) not null,
-- NPO BIT not null, -- Moved to its own table
-- DNR BIT not null, -- Moved to its own table
-- Fall char(1) NOT NULL, -- Moved to its own table
-- LegalStatusId varchar(50) not null, Moved to Patient_Admission
SoundAlike bit,
-- PCU_ID varchar(10) not null, --- this was pcu_int_id
-- IPD_UnitID INT FOREIGN KEY REFERENCES IPD_Unit(IPD_UnitID),
-- Ward_ID  varchar(10), ---- SW
-- ICU_ID varchar(10), ---- 
-- PCU_ID varchar(10), ---- 
BHUDate datetime not null, 
Admitate DATETIME,
[Description] VARCHAR(MAX),
-- CountDownFromAdmit date, Calculated field
foreign key (MRNo) references Patient(MRNo),
-- foreign key (PatientId) references Patient(PatientId),
--foreign key (LegalStatusId) references LegalStatus(LegalStatusId),
foreign key (BedNo) references Bed(BedNo),
--physicianSeen char(1),
--InternistSeen char(1),
--preopFlag char(1)
)

Create table Flag
(
FlagId varchar(50) primary key,
FlagColor varchar(10),
[Description] varchar(50)
)

create table Patient_Flag
(
FlagId varchar(50),
InpatientId VARCHAR(10) NOT NULL,
-- AdmissionID int , Replaced by InpatientId
DateFrom datetime not null,
DateTo datetime not null,
primary key(InpatientId,FlagId),
foreign key (InpatientId) references Inpatient(InpatientId),
foreign key (FlagId) references Flag(FlagId)
)

Create table Allergy
(
AllergyId int primary key,
AllergyName varchar(25) not null
)

Create table Patient_Allergy
(
-- Patient_AllergyId varchar(50) primary key, NOT important
AllergyId int not null,
MRNo  VARCHAR(12) not null,
[Description] varchar(50),
PRIMARY KEY (AllergyId, MRNo),
foreign key(AllergyId) references Allergy(AllergyId),
foreign key(MRNo) references Patient(MRNo)
)

Create table Telemetry 
(
TelemetryId varchar(10) primary key,
TelemetryName VARCHAR(50) NOT NULL,
Description varchar(10)
)

Create table Patient_Telemetery
(
TelemetryId varchar(10) ,
InpatientId VARCHAR(10), -- Added & AdmissionId is removed
Description varchar(50),
DateFrom dateTIME NOT NULL,
DateTo dateTIME,
primary key (TelemetryId, InpatientId),
foreign key (TelemetryId) references Telemetry(TelemetryId),
foreign key (InpatientId) references InPatient(InpatientId)
)

create table PatientVisit
(
VisitNum int primary key identity,
VisiterId varchar(50) not null,
VisitDate datetime DEFAULT GETDATE(),
Bp decimal(10,5),
HeartRate int,
ColestrolLevel decimal(10,5),
AdditionalSymptom varchar(max),
Note varchar(max),
AdmissionId int,
foreign key (AdmissionId) references Patient_Admission(AdmissionId),
CHECK (ColestrolLevel>5 or ColestrolLevel<300),
CHECK (HeartRate>29 or HeartRate<150)
)

CREATE TABLE Patient_Fall
(
InpatientId VARCHAR(10) FOREIGN KEY REFERENCES Inpatient(InpatientId),
FallNo TINYINT,
Fall BIT DEFAULT 1,
DateTimeStart DATETIME DEFAULT GETDATE(),
DateTimeEnd DATETIME,
[Description] VARCHAR(MAX),
PRIMARY KEY (InpatientId, FallNo)
)

CREATE TABLE Patient_DNR
(
InpatientId VARCHAR(10) FOREIGN KEY REFERENCES Inpatient(InpatientId),
DNRNo TINYINT,
DNR BIT,
DateTimeStart DATETIME DEFAULT GETDATE(),
DateTimeEnd DATETIME,
[Description] VARCHAR(MAX),
PRIMARY KEY (InpatientId, DNRNo)
)

CREATE TABLE Patient_NPO
(
InpatientId VARCHAR(10) FOREIGN KEY REFERENCES Inpatient(InpatientId),
NPONo TINYINT,
NPO BIT,
DateTimeStart DATETIME DEFAULT GETDATE(),
DateTimeEnd DATETIME,
[Description] VARCHAR(MAX),
PRIMARY KEY (InpatientId, NPONo)
)

CREATE TABLE Patient_Bpressure
(
AdmissionId INT foreign key references Patient_Admission(AdmissionId),
BPTestNo INT,
Result VARCHAR(10),
DateAndTime DATETIME DEFAULT GETDATE(),
NurseId INT FOREIGN KEY REFERENCES Employee(EmpId),
PRIMARY KEY (AdmissionId, BPTestNo),
FOREIGN KEY (NurseId) REFERENCES Nurse(NurseId)
)