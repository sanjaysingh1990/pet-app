import 'package:pet_app/model/pet.dart';

abstract class PetsService {
  Future<Pet> addPet(Pet newPet);

  Future<Pet> updatePet(Pet editedPet);

  Future<List<Pet>> getPetsForOwnerId(String ownerId);

  Future<List<Pet>> getMatingCompanionsForType(String type);
}