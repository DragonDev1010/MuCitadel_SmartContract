const { assert } = require('chai')

const MuCitadel = artifacts.require('./MuCitadel.sol')

require('chai').use(require('chai-as-promised')).should()

contract('MuCitadel', (accounts) => {
    let contract
    before(async() => {
        contract = await UniquMuCitadeleAsset.deployed()
    })

    describe('deployment', async () => {
        it('Deployes successfully', async () => {
            const address = contract.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })

        it('has a name', async() => {
            const name = await contract.name()
            assert.equal(name, 'MuCitadel')
        })

        it('has a symbol', async() => {
            const symbol = await contract.symbol()
            assert.equal(symbol, 'UNA')
        })
    })

    describe('emit NFT from ownerAddress, metadata and uri', async() => {
        it('award item', async () => {
            const recipient = '0x8247B67bb6Bc8Fa1A787F26BbEEB6b5acf477Df9'
            const hash = 'QmfAvnM89JrqvdhLymbU5sXoAukEJygSLk9cJMBPTyrmxo'
            const metadata = {
                "name": "nft image name",
                "description": "nft image description",
                "CID": "QmfAvnM89JrqvdhLymbU5sXoAukEJygSLk9cJMBPTyrmxo"
            }
            const awardedItemId = await contract.awardItem( recipient, hash, metadata)
            assert.equal(awardedItemId, 1)
            await contract.awardItem(recipient, hash, metadata).should.be.rejected;
        })
    })
})