import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:nvisust_test/src/services/base_response/base_reponse.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, Map<String, dynamic>>> getDocument(String collection,
      String docId, String subCollection, String subDocId) async {
    try {
      final doc = await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .get();
      if (doc.exists && doc.data() != null) {
        return Right(doc.data()!);
      } else {
        return Left(Failure(message: "Document not found"));
      }
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getCollectionAsList(
      String collection) async {
    try {
      final querySnapshot = await _firestore.collection(collection).get();
      final docs = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Right({"data": docs});
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getSubCollectionAsList(
      String collection, subCollection, String docId) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .where("is_leave", isEqualTo: true)
          .get();
      final docs = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Right({"data": docs});
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, void>> setDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, void>> setSubDocument(
      String collection,
      String subCollection,
      String docId,
      String subDocId,
      Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .set(data);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, bool>> checkIfDocumentExists(String collection,
      String docId, String subCollection, String subDocId) async {
    try {
      final docSnapshot = await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .get();

      return Right(docSnapshot.exists);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, void>> updateData(String collection, String docId,
      String subCollection, String subDocId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .doc(subDocId)
          .update(data);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore Error: ${e.message}"));
    } catch (e) {
      return Left(Failure(message: "Unknown Error: ${e.toString()}"));
    }
  }
}
