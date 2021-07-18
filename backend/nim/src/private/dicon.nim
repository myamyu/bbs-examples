import ./repository

type DIContainer* = tuple
  bbsRepository: IBBSRepository

proc newDIContainer():DIContainer =
  return (
    bbsRepository: newMockBBSRepository().toInterface()
  )

let di* = newDIContainer()
