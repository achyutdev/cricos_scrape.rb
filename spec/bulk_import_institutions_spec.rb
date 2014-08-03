require 'spec_helper'

describe BulkImportInstitutions do

  describe '#perform' do
    let(:output_file) { {'data' => 'spec_institutions.json', 'ids' => 'spec_institution_ids.json'} }
    subject(:importer) { BulkImportInstitutions.new(output_file, min_id, max_id, input) }
    
    before do
      FileUtils.rm_rf(Dir[data_file_path("spec_*")])
      allow_any_instance_of(CricosScrape::InstitutionImporter).to receive(:scrape_institution).and_return(Institution.new(3), Institution.new(4))
    end

    context 'when no input file provided' do
      let(:min_id) { 3 }
      let(:max_id) { 4 }
      let(:input) { nil }

      context 'when institution exists' do
        context 'when successful data storage' do
          let!(:output) { capture_stdout { importer.perform } }

          it 'outputs success message' do
            expect(output).to include "Success with ProviderID"
          end

          it 'stores institutions data file' do
            expect(File.read(data_file_path(output_file['data']))).to eq [Institution.new(3), Institution.new(4)].to_json
          end

          it 'stores institution ids file' do
            expect(File.read(data_file_path(output_file['ids']))).to eq [3, 4].to_json
          end
        end

        context 'failed to save data' do
          before { allow_any_instance_of(JsonFileStore).to receive(:save).and_raise() }
          let!(:output) { capture_stdout { importer.perform } }

          it 'outputs error message' do
            expect(output).to include "Error writing to files with ProviderID"
          end
        end
      end

      context 'when institution is not exist ' do
        before { allow_any_instance_of(CricosScrape::InstitutionImporter).to receive(:scrape_institution).and_return(nil) }
        let!(:output) { capture_stdout { importer.perform } }

        it 'does not store institutions data to file' do
          expect(File.exist?(data_file_path(output_file['data']))).to be false
        end

        it 'does not store institution ids to file' do
          expect(File.exist?(data_file_path(output_file['ids']))).to be false
        end

        it 'outputs error message' do
          expect(output).to include "entered is invalid - please try another."
        end
      end
    end

    context 'when have input file' do
      let(:min_id) { nil }
      let(:max_id) { nil }
      let(:input) { 'data/tmp_input' }

      before do
        File.open(input, 'w') {|f| f.write("1,2,3,5") }
        #hide puts string on cli
        allow_any_instance_of(IO).to receive(:puts)
        importer.perform
      end

      it 'stores institution ids file' do
        expect(File.read(data_file_path(output_file['ids']))).to eq [1, 2, 3, 5].to_json
      end
    end
  end
end